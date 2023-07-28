// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SecuredBlocks is ERC721URIStorage {
    address public owner;
    using Counters for Counters.Counter;
    Counters.Counter internal _tokenIdCounter;

    mapping(address => uint256[]) private _tokensByOwner;
    mapping(address => Patient) private mappedPatient;
    mapping(address => Hospital) private mappedHospital;

    constructor() ERC721("SecuredBlocks", "SB") {
        owner = msg.sender;
    }

    struct Patient {
        address[] authorizedHospitals;
    }

    struct Hospital {
        address[] patientAddresses;
    }

    function getAccessedPatientData() public view returns (address[] memory) {
        return mappedHospital[msg.sender].patientAddresses;
    }

    // grant hospital address to access patient's Data
    function grantAccess(address _hospitalAddress) public {
        mappedPatient[msg.sender].authorizedHospitals.push(_hospitalAddress);
        mappedHospital[_hospitalAddress].patientAddresses.push(msg.sender);
    }

    // patient accessing the list of authorized Hospitals
    function getAuthorizedHospitals() public view returns (address[] memory) {
        return mappedPatient[msg.sender].authorizedHospitals;
    }

    function revokeAccess(address _hospitalAddress) public {
        address[] storage authorizedHospitals = mappedPatient[msg.sender]
            .authorizedHospitals;
        for (uint256 i = 0; i < authorizedHospitals.length; i++) {
            if (authorizedHospitals[i] == _hospitalAddress) {
                authorizedHospitals[i] = authorizedHospitals[
                    authorizedHospitals.length - 1
                ];
                authorizedHospitals.pop();
                address[] storage patientAddresses = mappedHospital[
                    _hospitalAddress
                ].patientAddresses;
                for (uint256 j = 0; j < patientAddresses.length; j++) {
                    if (patientAddresses[j] == msg.sender) {
                        patientAddresses[j] = patientAddresses[
                            patientAddresses.length - 1
                        ];
                        patientAddresses.pop();
                        break;
                    }
                }
                break;
            }
        }
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
    function getTokenIdsByAddress(
        address _address
    ) public view returns (uint256[] memory) {
        return _tokensByOwner[_address];
    }
}
