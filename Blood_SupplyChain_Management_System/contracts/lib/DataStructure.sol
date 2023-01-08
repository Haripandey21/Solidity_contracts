// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract DataStructure {
    address public owner;
    uint256 internal supplier_id;
    uint256 internal hospital_id;
    address[] public suppliers;
    address[] public hospitals;
    uint256 internal blood_unique_id;

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
    struct bloodDetails{
        uint256 blood_unique_id;
        string blood_group;
        uint256 donated_time;
        Status current_status;
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
        uint256 age;
        string Address;
        string blood_group;
        uint256 used_time;
    }

    mapping(uint256 => supplier) internal mappedSupplier;
    mapping(uint256 => hospital) internal mappedHospital;
    mapping(uint256 => donor) internal mappedDonor;
    mapping(uint256 => patient) internal mappedPatient;
    mapping(uint256 => bloodDetails) internal mappedBloodDetails;


enum Status {    
     pending,  // no record of blood, 
     Active,  // Donor donated his blood & yet to be shipped to Hospital 
     Shipped, // Blood shipped to Hospital * yet to be used by Patients
     Fulfilled // Blood Used by patient 
} 
}
