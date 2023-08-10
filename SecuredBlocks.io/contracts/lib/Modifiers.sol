// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;
import "./DataStructure.sol";

contract modifiers is DataStructure {
    modifier checkGrantPermission(address _entityAddress) {
        require(
            mappedEntities[msg.sender][_entityAddress] != true,
            "Permission Already Granted !!"
        );
        _;
    }

    modifier checkOwner(address _entityAddress) {
        require(
            msg.sender != _entityAddress,
            "You cannot grant access to yourself"
        );
        _;
    }

    modifier checkRevokePermission(address _entityAddress) {
        require(
            mappedEntities[msg.sender][_entityAddress] == true,
            "Access has not been granted or has already been revoked"
        );
        _;
    }
}
