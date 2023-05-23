const { ethers } = require("hardhat");

async function main() {
  const TimeLockContract = await ethers.getContractFactory("TimeLock");
  const deployedTimeLockContract = await TimeLockContract.deploy(
    "3600",
    ["0x70997970C51812dc3A010C7d01b50e0d17dc79C8", "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC"],
    [],
    "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"
  );
  await deployedTimeLockContract.deployed(); 
    console.log(
    "deployed Contract address of TimeLock :",deployedTimeLockContract.address );
}
main()
 .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});

export {deployedTimeLockContract};
 