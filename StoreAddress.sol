// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract MetaMaskExample {
    // Variable to store a user's address
    address public userAddress;

    // Event to log when an address is stored
    event AddressStored(address indexed user);

    // Function to store an address dynamically (passed as an argument)
    function setAddressManually(address _address) public {
        userAddress = _address; // Store the provided address
        emit AddressStored(_address); // Emit the event
    }

    // Function to automatically store the caller's address
    function setAddressAutomatically() public {
        userAddress = msg.sender; // Store the sender's address (MetaMask caller)
        emit AddressStored(msg.sender); // Emit the event
    }

    // Function to retrieve the stored address
    function getAddress() public view returns (address) {
        return userAddress;
    }
}
