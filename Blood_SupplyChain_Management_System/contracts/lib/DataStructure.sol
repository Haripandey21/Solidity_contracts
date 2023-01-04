// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;
 
 contract DataStructure{

address public owner; 
uint256 internal supplier_id;
uint256 internal hospital_id; 
address[] public suppliers;
address[] public hospitals;
uint256[] public blood_unique_ids;

struct donor{
    string donor_name;
    uint256 age;
    string gender;
    string Address;
    string blood_group;
    uint256 blood_volume;
    uint256 blood_unique_id;
    uint256 donated_time;
}

struct supplier{
    address[] supplierAddreses;
    string organization_name;

 }

 struct hospital{
    address[] HospitalAddreses;
    string hospital_name;
 }

  struct patient{
    string patient_name;
    string age;
    string Address;
    string blood_group;
    uint256 used_time;
 }

mapping(uint256 => supplier) internal mappedSupplier;
mapping(uint256 => hospital) internal mappedHospital;
mapping (uint256 => donor) internal mappedDonor;  
mapping(uint256 => patient) internal mappedPatient; 



 }