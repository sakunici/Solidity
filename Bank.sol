// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Bank is Ownable {
    mapping (address => uint256) private balances;

    uint256 public rate =3;   // interest rate, fixed rate :3%
    address[] public accounts; // to keep it in array 

    constructor(address initialOwner) Ownable(initialOwner) {}

    function deposit() public payable {
        if (0 == balances[msg.sender]) {
            accounts.push (msg.sender);
        } 
        balances [msg.sender] += msg.value;
    }


    function fetchAccounts() public view returns (address [] memory) {
        return accounts; // to view if it's correct
    }

// Question is For depostor who has 1 ether or above, get 6% interest, Other get 3% interest
      function calculateInterest(address user, uint256 _rate) private view returns (uint256) {
        uint256 interest;
        uint256 balance = balances[user];
        
        if (balance >= 1 ether) {
            interest = balance * _rate * 2 / 100;
        } else {
            interest = balance * _rate / 100;
        }
         
        return interest;
    }

    // this is for Admin to see the interest for preparing deposit money to pay interest
    function totalInterestPerYear() public view returns (uint256) {
        uint256 totalInterest = 0;
        for (uint256 i = 0; i < accounts.length; i++) {
            address account = accounts[i];
            // uint256 interest = balances[account] * rate / 100;
            uint256 interest = calculateInterest(account, rate);
            totalInterest += interest;
        }
        return totalInterest;
    }


    function payDividensPerYear()public payable onlyOwner {    // to pay interest
        uint256 totalInterest =0;
        for (uint256 i = 0;i < accounts.length; i++) {
            address account = accounts [i]; // account = "accounts" to save gas fee
            uint256 interest = balances [account] * rate /100;  // to calculate interest
            balances [account] += interest;  // balance + interest = total balance
            totalInterest += interest;
        }
        require(msg.value == totalInterest, "Not enough interest to pay!");
    }

    // View balance
    function balanceOf(address user) public view returns (uint256) {
        return balances[user];
    }

    // Withdraw
    function withdraw(uint256 amount) public  {
        require(balances[msg.sender] >= amount, "Balance is not enough");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // Transfer
    function transfer(address to, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Balance is not enough");
        balances [msg.sender] -= amount;
        balances [to] += amount;
    }

     function systemDeposit() public payable onlyOwner{

    }
    
    function systemWithdraw (uint256 amount) public onlyOwner{
        require(address (this).balance <= amount, "Insufficient fund!");
        payable (owner()).transfer(amount) ;
    }

    

}
