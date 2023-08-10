// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract DataStructure {
    address public owner;

    struct Entity {
        address[] authorizedEntities;
    }
    mapping(address => uint256[]) internal _tokensByOwner;
    mapping(address => Entity) internal patientAndHospitalRecords;
    mapping(address => mapping(address => bool)) internal mappedEntities;
}
