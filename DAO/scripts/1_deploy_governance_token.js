const { ethers } = require("hardhat");

async function main() {
  const GovernanceTokenContract = await ethers.getContractFactory("GovernanceToken");
  const deployedGovernanceToken = await GovernanceTokenContract.deploy();
   deployedGovernanceTokenAddress = await deployedGovernanceToken.address;
  await deployedGovernanceToken.deployed(); 
    console.log(
 
     "deployed Contract address of governanceToken :",deployedGovernanceToken.address );
   
    }

main()
 .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});

export {deployedGovernanceTokenAddress};