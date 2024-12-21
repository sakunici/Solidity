// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0; 

contract Allowance {
    address public owner;
    mapping(address => uint256) public allowances;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setAllowance(address kid, uint256 amount) public onlyOwner {
        allowances[kid] = amount;
    }

    function getAllowance(address kid) public view returns (uint256) {
        return allowances[kid];
    }

    function spendAllowance(address kid, uint256 amount) public onlyOwner {
        require(allowances[kid] >= amount, "Insufficient allowance");
        allowances[kid] -= amount;
    }
}
