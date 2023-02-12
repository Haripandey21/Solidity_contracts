// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;
import "./DataStructure.sol";

contract Modifiers is DataStructure {
    modifier checkOwner(address _owner) {
        require(_owner == owner, "you are not a Owner !!");
        _;
    }

    modifier checkSupplier(address _entity) {
        require(
            authorizedSuppliers[_entity],
            "You are not a Authorized Supplier !!"
        );
        _;
    }

    modifier checkHospital(address _entity) {
        require(
            authorizedHospitals[_entity],
            "You are not a Authorized Hospital !!"
        );
        _;
    }

    modifier existsHospitalPermission(address _addresss) {
        require(
            authorizedHospitals[_addresss],
            "No permision to Ship Blood Here !!"
        );
        _;
    }
}
