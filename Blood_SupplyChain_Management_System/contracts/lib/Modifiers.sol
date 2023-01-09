// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;
import "./DataStructure.sol";

contract Modifiers is DataStructure {
    modifier checkOwner(address _owner) {
        require(_owner == owner, "you are not a Owner !!");
        _;
    }

  modifier checkSupplier(address _entity) {
    require(supplier_id > 0, "There are no suppliers registered yet");
    for (uint256 i = 0; i < supplier_id; i++) {
        require(
            _entity == suppliers[i],
            "You are not a Authorized Supplier !!"
        );
    }
    _;
}


    modifier checkHospital(address _entity) {
         require(hospital_id > 0, "There are no Hospitals registered yet");
        for (uint256 i = 0; i < hospital_id; i++) {
            require(
                _entity == hospitals[i],
                "You are not a Authorized Hospital !!"
            );
        }
        _;
    }

      modifier existsHospitalPermission(address _addresss)
    {
    require(hospital_id > 0, "There are no Hospitals registered yet");
        for (uint256 i = 0; i <hospital_id; i++) {
            require(
                _addresss == hospitals[i],
                "No permision to Ship Blood Here !!"
            );
        }
        _;
        
    }


}
