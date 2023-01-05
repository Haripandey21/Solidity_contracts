// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Events {
    event eventBloodAddded(
        uint256 blood_unique_id,
        string blood_group,
        uint256 blood_volume,
        uint256 donated_time
    );
    event eventSupplierAdded(
        address supplier,
        string organization_name,
        uint256 addedTime
    );
    event eventHospitalAdded(
        address hospital,
        string hospital_name,
        uint256 addedTime
    );
}
