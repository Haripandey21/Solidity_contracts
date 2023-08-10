## SecuredBlocks Smart Contract
SecuredBlocks is a Solidity smart contract designed to provide secure and controlled access to sensitive data stored on the Ethereum blockchain. It extends the ERC721 standard for non-fungible tokens (NFTs) and includes unique features for managing authorized entities' access to data.

Getting Started :
To interact with the SecuredBlocks smart contract, follow these steps:

* Deploy the smart contract on the Ethereum blockchain.
* Use the grantAccess function to allow an entity (patient/hospital) to access your data.
* Use the getAuthorizedEntities function to retrieve a list of entities that have been
   granted  access to your data.
* If needed, use the revokeAccess function to revoke access from an entity.
* Mint new NFTs with associated data using the safeMint function.

```bash 
Deployed and verfified at : 
https://goerli.etherscan.io/address/0xfE976Fc362E64c4Ef7638B2D64EA52608479b05E

deployed contract address : 0xfE976Fc362E64c4Ef7638B2D64EA52608479b05E


future enhancement :
-->> Streamline future upgrades by eliminating the need for the getter function, 
     such as  getAuthorizedEntities. Instead, enhance efficiency by emitting events and utilizing indexed msg.sender.
     
```
Note: This document provides a brief overview of the SecuredBlocks smart contract. For complete details, including function parameters and usage considerations, refer to the source code and relevant documentation. 
