// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract assetManagement {
    address public owner;
    uint256 average_buying_price;
    string[] public arrayTokensData;
    string[] public arrayExchangeData;

    constructor() {
        owner = msg.sender;
    }

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
        string token_name;
        uint256 quantity;
    }

    mapping(string => mapping(string => holdings)) public mappedHoldings;

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
        string memory _exchange,
        string memory _token_name
    ) {
        require(
            mappedHoldings[_exchange][_token_name].exists == true,
            "No such token Exists here"
        );
        _;
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
    }
}
