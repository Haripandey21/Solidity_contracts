const { ethers } = require("hardhat");

async function main() {
  const whiteListedContract = await ethers.getContractFactory("AssetManagement");
  const deployedwhiteListedContract = await whiteListedContract.deploy(100);
  console.log("Whitelist deployed Contract Address:-", deployedwhiteListedContract.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });