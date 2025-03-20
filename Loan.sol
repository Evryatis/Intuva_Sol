// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface Intuva_Deposit {
    function returnDeposits(address account) external view returns (uint);
    function deposit(uint amount) external payable;
    function withdraw(address account, uint amount) external payable;

}

contract Loan {

    address public owner;


    constructor() {
        owner = msg.sender;
    }

    mapping(address => uint256) public loans; // Tracks each user's loan amount

    uint public totalBorrowing;

    address public Intuva_DepositAddress;

    function setDepositContractAddress(address _loanContract) external {
        require(Intuva_DepositAddress == address(0), "Loan contract already set!");
        require(msg.sender == owner, "Not authorized");
        Intuva_DepositAddress = _loanContract;
    }

    function returnTotalBorrowing() view external returns (uint){
        return totalBorrowing;
    }

    // Function to give a loan
    function getLoan(uint amount) external payable {
        // Ensure msg.value (loan amount) is greater than 0
        require(amount > 0, "Loan amount must be greater than 0");

        totalBorrowing += amount;
        Intuva_Deposit(Intuva_DepositAddress).withdraw(msg.sender, amount);
        // Update the loan balance
        loans[msg.sender] += amount;
    }

    function returnLoanBal(address user) view external returns (uint loan){
        return loans[user] / 1 ether;
    }

    function repayLoan(uint amount) external payable {
        Intuva_Deposit(Intuva_DepositAddress).deposit(amount);
        loans[msg.sender] -= amount;
    }

}
