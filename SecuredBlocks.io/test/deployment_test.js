const { expect } = require("chai");
const hre = require("hardhat");

describe("Deployment testing...", function () {
  it("deployment should work ", async function () {
    const deployedContract = await hre.ethers.deployContract("SecuredBlocks");
    await deployedContract.waitForDeployment();
    console.log("SecuredBlocks Contract Address:", deployedContract.target);
  });
});
