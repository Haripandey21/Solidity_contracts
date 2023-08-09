// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract DataStructure {
    address public owner;
    mapping(address => uint256[]) internal _tokensByOwner;
    mapping(address => address[]) internal mappedPatient;
    mapping(address => address[]) internal mappedHospital;
}
