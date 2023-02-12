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
        address _supplierAddress,
        string memory _supplierName,
        uint256 _phoneNumber
    ) public checkOwner(msg.sender) {
        mappedSupplier[supplierId] = Supplier(
            _supplierAddress,
            _supplierName,
            _phoneNumber,
            block.timestamp
        );
        authorizedSuppliers[_supplierAddress] = true;
        suppliers.push(_supplierAddress);
        supplierId++;
        emit EventSupplierAdded(
            _supplierAddress,
            _supplierName,
            _phoneNumber,
            block.timestamp
        );
    }

    function addHospital(
        address _hospitalAddress,
        string memory _hospitalName,
        uint256 _phoneNumber
    ) public checkOwner(msg.sender) {
        mappedHospital[hospitalId] = Hospital(
            _hospitalAddress,
            _hospitalName,
            _phoneNumber,
            block.timestamp
        );
        authorizedHospitals[_hospitalAddress] = true;
        hospitals.push(_hospitalAddress);
        hospitalId++;
        emit EventHospitalAdded(
            _hospitalAddress,
            _hospitalName,
            _phoneNumber,
            block.timestamp
        );
    }

    //--------------------     Functions for Suppliers   --------------
    function addBlood(
        string memory _donorName,
        uint256 _age,
        string memory _gender,
        string memory _Address,
        string memory _bloodGroup,
        uint256 _bloodVolume
    ) public checkSupplier(msg.sender) {
        mappedDonor[bloodUniqueId] = Donor(
            _donorName,
            _age,
            _gender,
            _Address,
            _bloodGroup,
            _bloodVolume,
            bloodUniqueId,
            block.timestamp
        );
        mappedBloodDetails[bloodUniqueId].currentStatus = Status.Active;
        bloodUniqueId++;
    }

    function shipBloodToHospital(
        uint _blood_id,
        address _hospitalAddress
    )
        public
        checkSupplier(msg.sender)
        existsHospitalPermission(_hospitalAddress)
    {
        mappedBloodDetails[_blood_id].currentStatus = Status.Shipped;
        emit EventBloodShipped(
            msg.sender,
            _blood_id,
            _hospitalAddress,
            block.timestamp
        );
    }

    //--------------------------------Function for Hospitals ------------

    function giveBloodToPatients(
        uint256 _blood_id,
        string memory _patientName,
        uint256 _age,
        string memory _address,
        string memory _bloodGroup
    ) public checkHospital(msg.sender) {
        mappedPatient[_blood_id] = Patient(
            _patientName,
            _age,
            _address,
            _bloodGroup,
            _blood_id,
            block.timestamp
        );
        patients.push(_blood_id);
        mappedBloodDetails[_blood_id].currentStatus = Status.Fulfilled;
    }

    //----------------------------   Functions for Public  -------------
    function getDataOfSuppliers() external view returns (Supplier[] memory) {
        // new array of structure
        Supplier[] memory supplierData = new Supplier[](suppliers.length);
        for (uint256 i = 0; i < suppliers.length; i++) {
            Supplier memory newStructData = Supplier(
                mappedSupplier[i].supplierAddress,
                mappedSupplier[i].organizationName,
                mappedSupplier[i].phoneNumber,
                mappedSupplier[i].addedTime
            );
            supplierData[i] = newStructData;
        }
        return supplierData;
    }

    function getDataOfHospitals() external view returns (Hospital[] memory) {
        Hospital[] memory hospitalData = new Hospital[](hospitals.length);
        for (uint256 i = 0; i < hospitals.length; i++) {
            Hospital memory newStructData = Hospital(
                mappedHospital[i].hospitalAddress,
                mappedHospital[i].hospital_name,
                mappedHospital[i].phoneNumber,
                mappedHospital[i].addedTime
            );
            hospitalData[i] = newStructData;
        }
        return hospitalData;
    }

    function getDataOfBlood() external view returns (BloodDetails[] memory) {
        BloodDetails[] memory bloodData = new BloodDetails[](bloodUniqueId);
        for (uint256 i = 0; i < bloodUniqueId; i++) {
            BloodDetails memory newStructData = BloodDetails(
                mappedDonor[i].bloodUniqueId,
                mappedDonor[i].bloodGroup,
                mappedDonor[i].donatedTime,
                mappedBloodDetails[i].currentStatus
            );
            bloodData[i] = newStructData;
        }
        return bloodData;
    }

    function getBloodStatus(uint256 _id) external view returns (string memory) {
        return
            (mappedBloodDetails[_id].currentStatus == Status.Active)
                ? "Active"
                : (mappedBloodDetails[_id].currentStatus == Status.Shipped)
                ? "Shipped"
                : (mappedBloodDetails[_id].currentStatus == Status.Fulfilled)
                ? "Fulfilled"
                : "No record of that Blood_id";
    }

    // function only for owner
    function getDataOfDonors()
        external
        view
        checkOwner(msg.sender)
        returns (Donor[] memory)
    {
        Donor[] memory donorData = new Donor[](bloodUniqueId);
        for (uint256 i = 0; i < bloodUniqueId; i++) {
            Donor memory newStructData = Donor(
                mappedDonor[i].donorName,
                mappedDonor[i].age,
                mappedDonor[i].gender,
                mappedDonor[i].Address,
                mappedDonor[i].bloodGroup,
                mappedDonor[i].bloodVolume,
                mappedDonor[i].bloodUniqueId,
                mappedDonor[i].donatedTime
            );
            donorData[i] = newStructData;
        }
        return donorData;
    }

    function getDataOfPatients()
        external
        view
        checkOwner(msg.sender)
        returns (Patient[] memory)
    {
        Patient[] memory patientData = new Patient[](bloodUniqueId);
        for (uint256 i = 0; i < patients.length; i++) {
            Patient memory newStructData = Patient(
                mappedPatient[i].patientName,
                mappedPatient[i].age,
                mappedPatient[i].Address,
                mappedPatient[i].bloodGroup,
                mappedPatient[i].usedBloodId,
                mappedPatient[i].usedTime
            );
            patientData[i] = newStructData;
        }
        return patientData;
    }
}
