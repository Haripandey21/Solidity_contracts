const { expect } = require("chai");
const hre = require("hardhat");

describe("Deployment testing...", function () {
  it("deployment should work ", async function () {
    const instanceContract = await hre.ethers.getContractFactory("SecuredBlocks");
    const deployedContract = await instanceContract.deploy();
    expect(typeof (deployedContract.address) != null);
    console.log("Deployed SecuredBlocks Contract Address :-", deployedContract.address);
  });
})
