// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Events {
  event EventSupplierAdded(
        address supplier,
        string organizationName,
        uint256 phoneNumber,
        uint256 addedTime
    );
    event EventHospitalAdded(
        address hospital,
        string hospitalName,
        uint256 phoneNumber,
        uint256 addedTime
    );
    event EventBloodShipped(
        address supplierAddress,
        uint256 bloodId,
        address hospitalAddress,
        uint256 shippingTime
    );

}
