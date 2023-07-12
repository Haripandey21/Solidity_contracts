const { ethers } = require("hardhat");

async function main() {
  const SecuredBlocksContract = await ethers.getContractFactory("SecuredBlocks");
  const deployedSecuredBlocksContract = await SecuredBlocksContract.deploy();
  await deployedSecuredBlocksContract.deployed();
  console.log("SecuredBlocks Contract Address:-", deployedSecuredBlocksContract.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 