
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

interface Intuva_Deposit {
    function returnDeposits(address account) external view returns (uint);
}

contract Loan {

    mapping(address => uint256) public loans; // Tracks each user's loan amount

    // Function to give a loan
    function getLoan() external payable {

        // Ensure msg.value (loan amount) is greater than 0
        require(msg.value > 0, "Loan amount must be greater than 0");

        uint depositBalance = Intuva_Deposit(0x868742488c3190F783Fb358D43cd9BfE509b7E1A).returnDeposits(msg.sender);

        // Ensure the requested loan amount does not exceed 75% of the user's deposit
        require(
            loans[msg.sender] + msg.value <= depositBalance * 75 / 100,
            "Insufficient Ratio! Add more into your balance, or borrow less."
        );

        // Update the loan balance
        loans[msg.sender] += msg.value;

        // Transfer the funds from the contract to the receiver (msg.sender)
        payable(msg.sender).transfer(msg.value);
    }