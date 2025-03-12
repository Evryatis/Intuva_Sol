// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Deposit {
    
    mapping(address => uint) public balances; // Tracks each user's deposit
    

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function returnDeposits(address account) view external returns (uint){
        uint balance = balances[account];
        return balance;
    }

}




}