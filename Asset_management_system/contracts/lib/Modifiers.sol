// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./DataStructure.sol";

contract Modifiers is DataStructure{

    modifier onlyOwner(address _owner) {
        require(_owner == owner, "you are not owner");
        _;
    }

    modifier checkSufficientBalance(
        string memory _exchange,
        string memory _token_name,
        uint256 _balance
    ) {
        require(
            mappedHoldings[_exchange][_token_name].quantity > _balance,
            "Insufficient Balance !! "
        );
        _;
    }
    
      modifier checkAccountExist(
        string memory _exchange,  string memory _token_name
    ) {
        require(
            mappedHoldings[_exchange][_token_name].exists == true,
            "No such token Exists here"
        );
        _;
    }    
    
}