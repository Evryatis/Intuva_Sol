// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface Intuva_LoanSystem {
    function returnLoanBal(address user) view external returns (uint loan);
}

contract Deposit {

    address public owner;


    constructor() {
        owner = msg.sender;
    }

    address public Intuva_LoanAddress;


    mapping(address => uint) public balances; // Tracks each user's deposit

    uint public totalDeposits;  // Tracks all deposits in the protocol

    function setLoanContractAddress(address _loanContract) external {
        require(Intuva_LoanAddress == address(0), "Loan contract already set!");
        require(msg.sender == owner, "Not authorized");
        Intuva_LoanAddress = _loanContract;
    }

    function returnTotalDeposits() view external returns (uint){
        return totalDeposits;
    }
    
    function deposit() external payable {
        totalDeposits += msg.value;
        balances[msg.sender] += msg.value;
    }

    function returnDeposits(address account) view public returns (uint){
        uint balance = balances[account];
        return balance;
    }

    function withdraw(address account, uint amount) external payable {

        uint assets = returnDeposits(account);

        require(assets >= amount, "Not enough funds to withdraw");

        uint oldDebt = Intuva_LoanSystem(Intuva_LoanAddress).returnLoanBal(account);

        require((assets - ((oldDebt + amount) * 110 / 100)) > 0, "You're borrowing too much! Add collateral or withdraw less." );
        
        
        totalDeposits -=  amount;

        // Finally then, we allow the user to withdraw the money.
        (bool success,) = payable(account).call{value: amount}("");
        require(success, "Transfer failed.");
}

}
