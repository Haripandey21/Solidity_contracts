// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "./lib/DataStructure.sol";
import "./lib/Events.sol";
import "./lib/Modifiers.sol";

contract AssetManagement is DataStructure,Events,Modifiers {
      
    constructor() {
        owner = msg.sender;
    }

    function addTokens(
        string memory _exchange,
        string memory _token_name,
        uint256 _quantity,
        uint256 _buying_price
    ) public onlyOwner(msg.sender) {
        if (mappedHoldings[_exchange][_token_name].exists == true) {
            _quantity += mappedHoldings[_exchange][_token_name].quantity;
            mappedHoldings[_exchange][_token_name] = holdings(
                _exchange,
                _token_name,
                _quantity,
                _buying_price,
                true
            );
        } else {
            mappedHoldings[_exchange][_token_name] = holdings(
                _exchange,
                _token_name,
                _quantity,
                _buying_price,
                true
            );
            arrayTokensData.push(_token_name);
            arrayExchangeData.push(_exchange);
        }
        emit eventTokenAdded(_exchange,_token_name,_quantity,_buying_price);
    }

    function withDrawTokens(
        string memory _exchange,
        string memory _token_name,
        uint256 _balance
    )
        public
        onlyOwner(msg.sender)
        checkAccountExist(_exchange, _token_name)
        checkSufficientBalance(_exchange, _token_name, _balance)
    {
        mappedHoldings[_exchange][_token_name].quantity -= _balance;
        emit eventTokenWithdrawal(_exchange, _token_name,_balance);

    }

function getDataOfTokens() public view returns(tokenDetails[] memory){

tokenDetails[] memory getTokens = new tokenDetails[](arrayTokensData.length); // new array of structure
for(uint j=0;j<arrayExchangeData.length;j++)
{
 for (uint i=0;i<arrayTokensData.length;i++)

{
     if (mappedHoldings[arrayExchangeData[j]][arrayTokensData[i]].exists == true){
      tokenDetails memory newTokenData = tokenDetails(
                     mappedHoldings[arrayExchangeData[j]][arrayTokensData[i]].exchange,
                     mappedHoldings[arrayExchangeData[j]][arrayTokensData[i]].token_name,
                     mappedHoldings[arrayExchangeData[j]][arrayTokensData[i]].quantity
                ); // new struct to save data 

     getTokens[j]=newTokenData; // saving data to that new array
                 
     }
}
}
return getTokens;
}

}
