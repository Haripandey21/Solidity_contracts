// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;
import "./DataStructure.sol";

contract Modifiers is DataStructure {
    modifier checkOwner(address _owner) {
        require(_owner == owner, "you are not a Owner !!");
        _;
    }

    modifier checkSupplier(address _entity) {
        for (uint256 i = 0; i < supplier_id; i++) {
            if (_entity == suppliers[i]) {
                return;
            }
        }
        require(false, "You are not a Authorized Supplier !!");
        _;
    }

    modifier checkHospital(address _entity) {
        for (uint256 i = 0; i < hospital_id; i++) {
            if (_entity == hospitals[i]) {
                return;
            }
        }
        require(false, "You are not a Authorized Hospital !!");

        _;
    }

    modifier existsHospitalPermission(address _addresss) {
        for (uint256 i = 0; i < hospital_id; i++) {
            if( _addresss == hospitals[i]){
                return;
            }
            require(
                false,
                "No permision to Ship Blood Here !!"
            );
        }
        _;
    }
}
