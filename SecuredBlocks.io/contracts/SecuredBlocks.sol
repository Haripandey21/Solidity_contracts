// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SecuredBlocks is ERC721URIStorage {
    address public owner;
    using Counters for Counters.Counter;
    Counters.Counter internal _tokenIdCounter;

    mapping(address => uint256[]) private _tokensByOwner;

    constructor() ERC721("SecuredBlocks", "SB") {
        owner = msg.sender;
    }

    // mint nft
    function safeMint(string memory uri) public {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, uri);

        _tokensByOwner[msg.sender].push(tokenId);
    }

    // Get all token IDs owned by an address
    function getTokenIdsByAddress(address _address) public view returns (uint256[] memory) {
        return _tokensByOwner[_address];
    }

}
