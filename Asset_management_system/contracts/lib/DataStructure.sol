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
        // float is currently not supported in solidity, so to input quantity,
        // input its value by multiplying it with 1000, and for buying_price
        // multiply it with 100000.

        // you may be wondering what if firm is investing in safemars whose value is 0.0000000012,
        // i don't think any good campany would invest in shit coins with your money. we will later handle
        //  it with front-end to show you the exact quantity and buying_price.
    } 
    
     struct tokenDetails {
        string exchange;
        string token_name;
        uint256 quantity;
    }
    mapping(string => mapping(string => holdings)) public mappedHoldings; 
}