const { ethers } = require("hardhat");

async function main() {
  const BloodSupplyContract = await ethers.getContractFactory("BloodSupply");
  const deployedBloodSupplyContract = await BloodSupplyContract.deploy();
  await deployedBloodSupplyContract.deployed();
  console.log("BloodSupply Contract Address:-", deployedBloodSupplyContract.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  }); 