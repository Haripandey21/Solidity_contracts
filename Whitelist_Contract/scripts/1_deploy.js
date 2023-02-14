const { ethers } = require("hardhat");

async function main() {
  const whiteListedContract = await ethers.getContractFactory("Whitelist");
  const deployedwhiteListedContract = await whiteListedContract.deploy(500);
  console.log("Whitelist deployed Contract Address:-", deployedwhiteListedContract.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });