// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./lib/DataStructure.sol";
import "./lib/Modifiers.sol";

contract SecuredBlocks is ERC721URIStorage, DataStructure, modifiers {
    using Counters for Counters.Counter;
    Counters.Counter public _tokenIdCounter;

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

    // grant entity (patient/hospital) address to access data
    function grantAccess(
        address _entityAddress
    ) public checkGrantPermission(_entityAddress) checkOwner(_entityAddress) {
        mappedEntities[msg.sender][_entityAddress] = true;
        mappedEntities[_entityAddress][msg.sender] = true;

        patientAndHospitalRecords[msg.sender].authorizedEntities.push(
            _entityAddress
        );
        patientAndHospitalRecords[_entityAddress].authorizedEntities.push(
            msg.sender
        );
    }

    // revoke access from entity address to data
    function revokeAccess(
        address _entityAddress
    ) public checkRevokePermission(_entityAddress) {
        mappedEntities[msg.sender][_entityAddress] = false;
        mappedEntities[_entityAddress][msg.sender] = false;
    }

    // entity accessing the list of authorized entities
    function getAuthorizedEntities() public view returns (address[] memory) {
        Entity memory entity = patientAndHospitalRecords[msg.sender];
        address[] memory authorizedEntities = entity.authorizedEntities;
        address[] memory result = new address[](authorizedEntities.length);

        uint256 count = 0;
        for (uint256 i = 0; i < authorizedEntities.length; i++) {
            if (mappedEntities[msg.sender][authorizedEntities[i]]) {
                result[count] = authorizedEntities[i];
                count++;
            }
        }

        return result;
    }

    // Get all token IDs owned by an address
    function getTokenIdsByAddress(
        address _address
    ) public view returns (uint256[] memory) {
        return _tokensByOwner[_address];
    }
}
