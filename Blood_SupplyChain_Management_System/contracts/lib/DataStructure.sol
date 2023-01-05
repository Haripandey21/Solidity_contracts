// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract DataStructure {
    address public owner;
    uint256 internal supplier_id;
    uint256 internal hospital_id;
    address[] public suppliers;
    address[] public hospitals;
    uint256[] internal blood_unique_ids;
    uint256 internal blood_unique_id=1200;

    struct donor {
        string donor_name;
        uint256 age;
        string gender;
        string Address;
        string blood_group;
        uint256 blood_volume;
        uint256 blood_unique_id;
        uint256 donated_time;
    }

    struct supplier {
        address supplier_address;
        string organization_name;
        uint256 added_time;
    }

    struct hospital {
        address hospital_address;
        string hospital_name;
        uint256 added_time;
    }

    struct patient {
        string patient_name;
        string age;
        string Address;
        string blood_group;
        uint256 used_time;
    }

    mapping(uint256 => supplier) internal mappedSupplier;
    mapping(uint256 => hospital) internal mappedHospital;
    mapping(uint256 => donor) internal mappedDonor;
    mapping(uint256 => patient) internal mappedPatient;
}
