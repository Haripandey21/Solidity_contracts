// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract DataStructure{
    address public owner;
    uint256 average_buying_price;
    string[] public arrayTokensData;
    string[] public arrayExchangeData;

   struct holdings {
        string exchange;
        string token_name;
        uint256 quantity;
        uint256 buying_price;
        bool exists;
    } 
    
     struct tokenDetails {
        string exchange;
        string token_name;
        uint256 quantity;
    }
    mapping(string => mapping(string => holdings)) public mappedHoldings; 
}