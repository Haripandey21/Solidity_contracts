// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Events{

    event eventTokenAdded(
        string exchange,string token_name,uint256 quantity,uint256 buying_price

    );

    event eventTokenWithdrawal(
         string exchange,string token_name,uint256 quantity

    );

    event eventOwnerChanged(
        address newOwner
    );
    
}