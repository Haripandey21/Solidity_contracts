// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract BloodSupply{

address public owner; 

constructor(){
    owner=msg.sender;
}

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
    string location;
 }
 mapping(uint256 => supplier) public mappedSupplier;

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

mapping (uint256 => donor) public mappedDonor;  
mapping(uint256 => hospital) public mappedHospital;
mapping(uint256 => patient) public mappedPatient;


address[] public suppliers;
address[] public hospitals;
uint256[] public blood_unique_ids;


event eventBloodAddded(uint256 blood_unique_id,string blood_group, uint256 blood_volume,uint256 donated_time);
event eventSupplierAdded(address supplier,uint256 addedTime);
event eventHospitalAdded(address hospital,uint256 addedTime);




modifier checkOwner(address _owner) {
    require(_owner==owner,"you are not a Owner !!");
    _;
    
}

modifier checkSupplier(address _entity){
    for(uint256 i=0;i<suppliers.length;i++)
    {
    require(_entity==suppliers[i],"You are not a Authorized Supplier !! ");
    }
    _;
}

modifier checkHospital(address _entity){
    for(uint256 i=0;i<hospitals.length;i++)
    {
    require(_entity==hospitals[i],"You are not a Authorized Hospital !! ");
    }
    _;
} 

function addSupplier(address _supplierAddress) public checkOwner(msg.sender) {
    suppliers.push(_supplierAddress);
    emit eventSupplierAdded(_supplierAddress,block.timestamp);

}

function addhospital(address _hospitalAddress) public checkOwner(msg.sender) {
    hospitals.push(_hospitalAddress);
    emit eventHospitalAdded(_hospitalAddress,block.timestamp);
}

function addBlood(string memory _donor_name,
    uint256 _age,
    string memory _gender,
    string memory _Address,
    string memory _blood_group,
    uint256 _blood_volume)public 
    checkSupplier(msg.sender) returns(uint256) 
    {

uint256 _blood_unique_id=1200;
 mappedDonor[_blood_unique_id]=donor(_donor_name,_age,_gender,_Address,_blood_group,_blood_volume,_blood_unique_id,block.timestamp);
 blood_unique_ids.push(_blood_unique_id);
 emit eventBloodAddded(_blood_unique_id,_blood_group,_blood_volume,block.timestamp);
 return _blood_unique_id;
}

function



}
