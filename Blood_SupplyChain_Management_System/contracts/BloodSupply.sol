// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./lib/DataStructure.sol";
import "./lib/Events.sol";
import "./lib/Modifiers.sol";

contract BloodSupply is DataStructure, Events, Modifiers {
    constructor() {
        owner = msg.sender;
    }

    function addSupplier(
        address _supplier_address,
        string memory _organization_name
    ) public checkOwner(msg.sender) {
        mappedSupplier[supplier_id] = supplier(
            _supplier_address,
            _organization_name,
            block.timestamp
        );
        suppliers.push(_supplier_address);
        supplier_id++;
        emit eventSupplierAdded(
            _supplier_address,
            _organization_name,
            block.timestamp
        );
    }

    function addHospital(
        address _hospitalAddress,
        string memory _hospital_name
    ) public checkOwner(msg.sender) {
        mappedHospital[hospital_id] = hospital(
            _hospitalAddress,
            _hospital_name,
            block.timestamp
        );
        hospitals.push(_hospitalAddress);
        hospital_id++;
        emit eventHospitalAdded(
            _hospitalAddress,
            _hospital_name,
            block.timestamp
        );
    }

    function addBlood(
        string memory _donor_name,
        uint256 _age,
        string memory _gender,
        string memory _Address,
        string memory _blood_group,
        uint256 _blood_volume
    ) public checkSupplier(msg.sender) returns (uint256) {
        mappedDonor[blood_unique_id] = donor(
            _donor_name,
            _age,
            _gender,
            _Address,
            _blood_group,
            _blood_volume,
            blood_unique_id,
            block.timestamp,
            Status.Active
        );
        blood_unique_id++;
        emit eventBloodAddded(
            blood_unique_id,
            _blood_group,
            _blood_volume,
            block.timestamp
        );
        return blood_unique_id;
    }

    function getDataOfSuppliers() public view returns (supplier[] memory) {
        // new array of structure
        supplier[] memory supplierData = new supplier[](suppliers.length);
        for (uint256 i = 0; i < suppliers.length; i++) {
            supplier memory newStructData = supplier(
                mappedSupplier[i].supplier_address,
                mappedSupplier[i].organization_name,
                mappedSupplier[i].added_time
            );
            supplierData[i] = newStructData;
        }
        return supplierData;
    }

    function getDataOfHospitals() public view returns (hospital[] memory) {
        hospital[] memory hospitalData = new hospital[](hospitals.length);
        for (uint256 i = 0; i < hospitals.length; i++) {
            hospital memory newStructData = hospital(
                mappedHospital[i].hospital_address,
                mappedHospital[i].hospital_name,
                mappedHospital[i].added_time
            );
            hospitalData[i] = newStructData;
        }
        return hospitalData;
    }

    function getDataOfDonors() external view checkOwner(msg.sender) returns(donor[] memory){
        donor[] memory donorData= new donor[](blood_unique_id);
        for (uint256 i=0;i<blood_unique_id;i++){
            donor memory newStructData=donor(
                mappedDonor[i].donor_name,
                mappedDonor[i].age,
                 mappedDonor[i].gender,
                  mappedDonor[i].Address,
                   mappedDonor[i].blood_group,
                    mappedDonor[i].blood_volume,
                     mappedDonor[i].blood_unique_id,
                     mappedDonor[i].donated_time
            );
            donorData[i]=newStructData;
        }
        return donorData;
    } 

    function getDataOfBlood() external view returns(bloodDetails[] memory){
        bloodDetails[] memory bloodData= new bloodDetails[](blood_unique_id);
        for(uint256 i=0;i<blood_unique_id;i++){
            bloodDetails memory newStructData=bloodDetails(
                mappedDonor[i].blood_unique_id,
                mappedDonor[i].blood_group,
                mappedDonor[i].donated_time
            );
            bloodData[i]=newStructData;
        }
        return bloodData;
    }

}
