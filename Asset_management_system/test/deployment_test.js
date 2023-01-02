const { expect } = require("chai");
const hre = require("hardhat");

describe("Deployment testing", function () {
  it("deployment should work ", async function () {
    const instanceContract = await hre.ethers.getContractFactory("AssetManagement");
    const deployedContract = await instanceContract.deploy();
    expect(typeof (deployedContract.address)!=null);
    console.log("Deployed Contract Address :-",deployedContract.address);
  });
})


