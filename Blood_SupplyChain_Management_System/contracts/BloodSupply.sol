// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract BloodSupply{

address public owner; 
uint256 private supplier_id;
uint256 private hospital_id;

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

 }
mapping(uint256 => supplier) internal mappedSupplier;



struct hospital{
    address[] HospitalAddreses;
    string hospital_name;
 }
mapping(uint256 => hospital) internal mappedHospital;

 struct patient{
    string patient_name;
    string age;
    string Address;
    string blood_group;
    uint256 used_time;
 }

mapping (uint256 => donor) internal mappedDonor;  
mapping(uint256 => patient) internal mappedPatient;


address[] public suppliers;
address[] public hospitals;
uint256[] public blood_unique_ids;


event eventBloodAddded(uint256 blood_unique_id,string blood_group, uint256 blood_volume,uint256 donated_time);
event eventSupplierAdded(address supplier,string organization_name,uint256 addedTime);
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

function addSupplier(address _supplierAddress,string memory _organization_name) public checkOwner(msg.sender) {
    for(uint256 i=0;i<supplier_id;i++)   
    {
   if (  keccak256(bytes(mappedSupplier[i].organization_name)) == keccak256(bytes(_organization_name)))

        {
            mappedSupplier[i].supplierAddreses.push(_supplierAddress);
        }
        else 

         {
             //   It is not possible to cast between fixed size arrays and dynamic size arrays.
            //     so creating a temporary dynamic array and copy the elements.
            address[] memory t = new address[](1);
            t[0]=_supplierAddress;
            mappedSupplier[supplier_id + 1]=supplier(t,_organization_name);
            suppliers.push(_supplierAddress);
            supplier_id++;
        }
      
    }  
    emit eventSupplierAdded(_supplierAddress,_organization_name,block.timestamp);

}




}
