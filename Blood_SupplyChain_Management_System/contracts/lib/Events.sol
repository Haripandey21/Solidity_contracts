// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

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
        uint256 phone_number,
        uint256 added_time
    );
    event eventHospitalAdded(
        address hospital,
        string hospital_name,
        uint256 phone_number,
        uint256 added_time
    );
    event eventBloodShipped(
        address supplier_address,
        uint256 blood_id,
        address hospital_address,
        uint256 shipping_time
    );
    event eventBloodUsedByPatient(
        address hospital_address,
        uint256 blood_id,
        uint256 used_time
    );
}
