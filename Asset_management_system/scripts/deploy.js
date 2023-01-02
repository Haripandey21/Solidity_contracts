const { ethers } = require("hardhat");

async function main() {
  const assetContract = await ethers.getContractFactory("AssetManagement");
  const deployedassetContract = await assetContract.deploy();
  await deployedassetContract.deployed();
  console.log("Asset_Management Contract Address:-", deployedassetContract.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });