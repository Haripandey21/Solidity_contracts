//SPDX-License-Identifier:MIT
pragma solidity ^0.8.16;

contract Whitelist {
    uint256 public immutable maxWhiteListedAddresses;
    uint256 public numAddressesWhiteListed;
    mapping(address => bool) internal mappedWhiteListedAddresses;

    constructor(uint8 _maxWhiteListedAddresses) {
        maxWhiteListedAddresses = _maxWhiteListedAddresses;
    }

    function addAddressToWhitelist() public  {
        require(
            !mappedWhiteListedAddresses[msg.sender],
            "Sender has already been whitelisted"
        );
        require(
            numAddressesWhiteListed < maxWhiteListedAddresses,
            "limit reached"
        );
        mappedWhiteListedAddresses[msg.sender] = true;
        numAddressesWhiteListed += 1;
    }
}
