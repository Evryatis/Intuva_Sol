// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface Intuva_Deposit {
    function returnDeposits(address account) external view;
    function deposit(uint amount) external payable;
    function withdraw(address account, uint amount) external payable;
    function returnTotalDeposits() view external returns (uint);
}

interface Intuva_LoanSystem {
    function returnTotalBorrowing() view external returns (uint);
}

contract Global_InterestIndex {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    mapping(address => uint256) public userInterestIndex;

    address Intuva_DepositAddress;
    
    uint256 lastUpdate;

    function setDepositContractAddress(address _depositContract) external {
        require(Intuva_DepositAddress == address(0), "Deposit contract already set!");
        require(msg.sender == owner, "Not authorized");
        Intuva_DepositAddress = _depositContract;
    }

    function setLoanContractAddress(address _loanContract) external {
        require(Intuva_DepositAddress == address(0), "Loan contract already set!");
        require(msg.sender == owner, "Not authorized");
        Intuva_DepositAddress = _loanContract;
    }


    }

    
}
