const { ethers } = require("hardhat");
import { deployedGovernanceToken } from "./1_deploy_governance_token.js";
import { deployedTimeLockContract } from "./2_deploy_timelock";

async function main() {
  const GovernorContract = await ethers.getContractFactory("GovernorContract");
  const deployedGovernorContract = await GovernorContract.deploy(
  deployedGovernanceToken.address,
  deployedTimeLockContract.address,
  "4",
  "5",
  "1"  
  );
  await deployedGovernorContract.deployed(); 
    console.log(
    "deployed Contract address of governorContract :",deployedGovernorContract.address );
}
main()
 .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});

