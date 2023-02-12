// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract DataStructure {
    address public owner;
    uint256 internal supplierId;
    uint256 internal hospitalId;
    address[] public suppliers;
    address[] public hospitals;
    uint256[] internal patients;
    uint256 internal bloodUniqueId;

    struct Donor {
        string donorName;
        uint256 age;
        string gender;
        string Address;
        string bloodGroup;
        uint256 bloodVolume;
        uint256 bloodUniqueId;
        uint256 donatedTime;
    }
    struct BloodDetails {
        uint256 bloodUniqueId;
        string bloodGroup;
        uint256 donatedTime;
        Status currentStatus;
    }

    struct Supplier {
        address supplierAddress;
        string organizationName;
        uint256 phoneNumber;
        uint256 addedTime;
    }

    struct Hospital {
        address hospitalAddress;
        string hospital_name;
        uint256 phoneNumber;
        uint256 addedTime;
    }

    struct Patient {
        string patientName;
        uint256 age;
        string Address;
        string bloodGroup;
        uint256 usedBloodId;
        uint256 usedTime;
    }

    mapping(uint256 => Supplier) internal mappedSupplier;
    mapping(uint256 => Hospital) internal mappedHospital;
    mapping(uint256 => Donor) internal mappedDonor;
    mapping(uint256 => Patient) internal mappedPatient;
    mapping(uint256 => BloodDetails) internal mappedBloodDetails;

    // mappings to check suppliers,hospitals in modifiers, so not to check by loops
    mapping(address => bool) internal authorizedSuppliers;
    mapping(address => bool) internal authorizedHospitals;

    enum Status {
        pending, // no record of blood,
        Active, // Donor donated his blood & yet to be shipped to Hospital
        Shipped, // Blood shipped to Hospital * yet to be used by Patients
        Fulfilled // Blood Used by patient
    }
}
