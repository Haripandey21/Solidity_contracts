// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./lib/DataStructure.sol";
import "./lib/Events.sol";
import "./lib/Modifiers.sol";

contract BloodSupply is DataStructure, Events, Modifiers {
    constructor() {
        owner = msg.sender;
    }

// ------------------------    Functions for Owner    -----------------------
    function addSupplier(
        address _supplier_address,
        string memory _organization_name,
         uint256 _phone_number
    ) public checkOwner(msg.sender) {
        mappedSupplier[supplier_id] = supplier(
            _supplier_address,
            _organization_name,
            _phone_number,
            block.timestamp
        );
        suppliers.push(_supplier_address);
        supplier_id++;
        emit eventSupplierAdded(
            _supplier_address,
            _organization_name,
            _phone_number,
            block.timestamp
        );
    }

    function addHospital(
        address _hospitalAddress,
        string memory _hospital_name,
        uint256 _phone_number 
    ) public checkOwner(msg.sender) {
        mappedHospital[hospital_id] = hospital(
            _hospitalAddress,
            _hospital_name,
            _phone_number,
            block.timestamp
        );
        hospitals.push(_hospitalAddress);
        hospital_id++;
        emit eventHospitalAdded(
            _hospitalAddress,
            _hospital_name,
            _phone_number,
            block.timestamp
        );
    }

//--------------------     Functions for Suppliers   --------------
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
            block.timestamp
        );
        mappedBloodDetails[blood_unique_id].current_status = Status.Active;
        blood_unique_id++;
        emit eventBloodAddded(
            blood_unique_id,
            _blood_group,
            _blood_volume,
            block.timestamp
        );
        return blood_unique_id;
    }

    function shipBloodToHospital(
        uint _blood_id,
        address _hospital_address
    )
        public
        checkSupplier(msg.sender)
        existsHospitalPermission(_hospital_address)
    {
        mappedBloodDetails[_blood_id].current_status = Status.Shipped;
        emit eventBloodShipped(msg.sender,_blood_id,_hospital_address,block.timestamp);
    }
//--------------------------------Function for Hospitals ------------

    function giveBloodToPatients(
        uint256 _blood_id,
        string memory _patient_name,
        uint256 _age,
        string memory _address,
        string memory _blood_group,
        uint256 _used_time
    ) public checkHospital(msg.sender) {
        mappedPatient[_blood_id] = patient(
            _patient_name,
            _age,
            _address,
            _blood_group,
            _blood_id,
            _used_time
        );
        patients.push(_blood_id);
        mappedBloodDetails[_blood_id].current_status = Status.Fulfilled;
        emit eventBloodUsedByPatient(msg.sender,_blood_id,block.timestamp);
    }

//----------------------------   Functions for Public  -------------
    function getDataOfSuppliers() external view returns (supplier[] memory) {
        // new array of structure
        supplier[] memory supplierData = new supplier[](suppliers.length);
        for (uint256 i = 0; i < suppliers.length; i++) {
            supplier memory newStructData = supplier(
                mappedSupplier[i].supplier_address,
                mappedSupplier[i].organization_name,
                mappedSupplier[i].phone_number,
                mappedSupplier[i].added_time
            );
            supplierData[i] = newStructData;
        }
        return supplierData;
    }

    function getDataOfHospitals() external view returns (hospital[] memory) {
        hospital[] memory hospitalData = new hospital[](hospitals.length);
        for (uint256 i = 0; i < hospitals.length; i++) {
            hospital memory newStructData = hospital(
                mappedHospital[i].hospital_address,
                mappedHospital[i].hospital_name,
                mappedHospital[i].phone_number,
                mappedHospital[i].added_time
            );
            hospitalData[i] = newStructData;
        }
        return hospitalData;
    }

    function getDataOfBlood() external view returns (bloodDetails[] memory) {
        bloodDetails[] memory bloodData = new bloodDetails[](blood_unique_id);
        for (uint256 i = 0; i < blood_unique_id; i++) {
            bloodDetails memory newStructData = bloodDetails(
                mappedDonor[i].blood_unique_id,
                mappedDonor[i].blood_group,
                mappedDonor[i].donated_time,
                mappedBloodDetails[i].current_status
            );
            bloodData[i] = newStructData;
        }
        return bloodData;
    }

      function getBloodStatus(uint256 _id) external view returns (string memory) {
        return
            (mappedBloodDetails[_id].current_status == Status.Active)
                ? "Active"
                : (mappedBloodDetails[_id].current_status == Status.Shipped)
                ? "Shipped"
                : (mappedBloodDetails[_id].current_status == Status.Fulfilled)
                ? "Fulfilled"
                : "No record of that Blood_id";
    }

    // function only for owner
    function getDataOfDonors()
        external
        view
        checkOwner(msg.sender)
        returns (donor[] memory)
    {
        donor[] memory donorData = new donor[](blood_unique_id);
        for (uint256 i = 0; i < blood_unique_id; i++) {
            donor memory newStructData = donor(
                mappedDonor[i].donor_name,
                mappedDonor[i].age,
                mappedDonor[i].gender,
                mappedDonor[i].Address,
                mappedDonor[i].blood_group,
                mappedDonor[i].blood_volume,
                mappedDonor[i].blood_unique_id,
                mappedDonor[i].donated_time
            );
            donorData[i] = newStructData;
        }
        return donorData;
    }

    function getDataOfPatients()
        external
        view
        checkOwner(msg.sender)
        returns (patient[] memory)
    {
        patient[] memory patientData = new patient[](blood_unique_id);
        for (uint256 i = 0; i < patients.length; i++) {
            patient memory newStructData = patient(
            mappedPatient[i].patient_name,
            mappedPatient[i].age,
             mappedPatient[i].Address,
              mappedPatient[i].blood_group,
              mappedPatient[i].used_blood_id,
               mappedPatient[i].used_time
            );
            patientData[i] = newStructData;
        }
        return patientData;
    }
  
}
