// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    event Approved(uint);

    constructor(address _arbiter, address _beneficiary) payable{
        depositor = msg.sender;
        beneficiary = _beneficiary;
        arbiter = _arbiter;
    }

    function approve() external {
        require(msg.sender == arbiter);

        (bool success, ) = beneficiary.call{value: address(this).balance}("");
        require(success);

        emit Approved(beneficiary.balance);
    }
}