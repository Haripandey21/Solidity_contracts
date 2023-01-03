const { expect } = require("chai");
const hre = require("hardhat");

describe("Deployment testing", function () {
  it("deployment should work ", async function () {
    const instancelottery = await hre.ethers.getContractFactory("AssetManagement");
    const deployedlottery = await instancelottery.deploy();
    expect(typeof (deployedlottery.address)!=null);
    console.log("Deployed Contract Address :-",deployedlottery.address);
  });
})


