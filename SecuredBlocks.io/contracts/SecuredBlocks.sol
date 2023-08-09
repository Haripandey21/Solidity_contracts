// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./lib/DataStructure.sol";

contract SecuredBlocks is ERC721URIStorage, DataStructure {
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

    // grant hospital address to access patient's Data
    function grantAccess(address _hospitalAddress) public {
        require(
            msg.sender != _hospitalAddress,
            "You cannot grant access to yourself"
        );

        mappedPatient[msg.sender].push(_hospitalAddress);
        mappedHospital[_hospitalAddress].push(msg.sender);
    }

    // patient accessing the list of authorized Hospitals
    function getAuthorizedHospitals() public view returns (address[] memory) {
        return mappedPatient[msg.sender];
    }

    // revoke access from hospital address to patient's Data
    function revokeAccess(address _hospitalAddress) public {
        address[] storage authorizedHospitals = mappedPatient[msg.sender];
        address[] storage patientAddresses = mappedHospital[_hospitalAddress];

        for (uint256 i = 0; i < authorizedHospitals.length; i++) {
            if (authorizedHospitals[i] == _hospitalAddress) {
                authorizedHospitals[i] = authorizedHospitals[
                    authorizedHospitals.length - 1
                ];
                authorizedHospitals.pop();
                break;
            }
        }

        for (uint256 j = 0; j < patientAddresses.length; j++) {
            if (patientAddresses[j] == msg.sender) {
                patientAddresses[j] = patientAddresses[
                    patientAddresses.length - 1
                ];
                patientAddresses.pop();
                break;
            }
        }
    }

    // Get all token IDs owned by an address
    function getTokenIdsByAddress(
        address _address
    ) public view returns (uint256[] memory) {
        return _tokensByOwner[_address];
    }

    function getAccessedPatientData() public view returns (address[] memory) {
        return mappedHospital[msg.sender];
    }
}
