// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./lib/DataStructure.sol";
import "./lib/Events.sol";
import "./lib/Modifiers.sol";

contract BloodSupply is DataStructure, Events, Modifiers {
    constructor() {
        owner = msg.sender;
    }

    function addhospital(
        address _hospitalAddress
    ) public checkOwner(msg.sender) {
        hospitals.push(_hospitalAddress);
        emit eventHospitalAdded(_hospitalAddress, block.timestamp);
    }

    function addBlood(
        string memory _donor_name,
        uint256 _age,
        string memory _gender,
        string memory _Address,
        string memory _blood_group,
        uint256 _blood_volume
    ) public checkSupplier(msg.sender) returns (uint256) {
        uint256 _blood_unique_id = 1200;
        mappedDonor[_blood_unique_id] = donor(
            _donor_name,
            _age,
            _gender,
            _Address,
            _blood_group,
            _blood_volume,
            _blood_unique_id,
            block.timestamp
        );
        blood_unique_ids.push(_blood_unique_id);
        emit eventBloodAddded(
            _blood_unique_id,
            _blood_group,
            _blood_volume,
            block.timestamp
        );
        return _blood_unique_id;
    }

    function addSupplier(
        address _supplierAddress,
        string memory _organization_name
    ) public checkOwner(msg.sender) {
        for (uint256 i = 0; i < supplier_id; i++) {
            if (
                keccak256(bytes(mappedSupplier[i].organization_name)) ==
                keccak256(bytes(_organization_name))
            ) {
                mappedSupplier[i].supplierAddreses.push(_supplierAddress);
            } else {
                //   It is not possible to cast between fixed size arrays and dynamic size arrays.
                //     so creating a temporary dynamic array and copy the elements.
                address[] memory t = new address[](1);
                t[0] = _supplierAddress;
                mappedSupplier[supplier_id + 1] = supplier(
                    t,
                    _organization_name
                );
                suppliers.push(_supplierAddress);
                supplier_id++;
            }
        }
        emit eventSupplierAdded(
            _supplierAddress,
            _organization_name,
            block.timestamp
        );
    }
}
