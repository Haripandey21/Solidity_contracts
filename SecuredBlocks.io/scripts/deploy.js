const { ethers } = require("hardhat");

async function main() {
  
  const deployedContract = await ethers.deployContract("SecuredBlocks");
  await deployedContract.waitForDeployment(); 
  console.log("SimpleStorage Contract Address:", deployedContract.target);

}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 