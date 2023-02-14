//SPDX-License-Identifier:MIT
pragma solidity ^0.8.16;

contract Whitelist {
    uint256 public immutable maxWhiteListedAddresses;
    uint256 public numAddressesWhiteListed;
    address[] public listWhiteListedAddress;
    mapping(address => bool) internal mappedWhiteListedAddresses;

    constructor(uint256 _maxWhiteListedAddresses) {
        maxWhiteListedAddresses = _maxWhiteListedAddresses;
    }

    function joinWhiteList() public  {
        require(
            !mappedWhiteListedAddresses[msg.sender],
            "Sender has already been whitelisted"
        );
        require(
            numAddressesWhiteListed < maxWhiteListedAddresses,
            "limit reached"
        );
        mappedWhiteListedAddresses[msg.sender] = true;
        listWhiteListedAddress.push(msg.sender);
        numAddressesWhiteListed += 1;
    }
}
