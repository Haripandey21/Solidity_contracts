const { expect } = require("chai");
const hre = require("hardhat");

describe("joinWhiteList function checking...", () => {
  beforeEach(async () => {
    [addr1, addr2, addr3] = await hre.ethers.getSigners();
    instanceContract = await hre.ethers.getContractFactory("Whitelist");
    deployedContract = await instanceContract.deploy(5);
  });
  it("Should revert with message if sender is already whitelisted...", async () => {
    await deployedContract.joinWhiteList();
    await expect(deployedContract.joinWhiteList())
      .to.be.revertedWith("Sender has already been whitelisted");
  });
  it("Should revert with message if limit is reached ...", async () => {
    await deployedContract.joinWhiteList();
    await deployedContract.connect(addr2).joinWhiteList();
   await expect(deployedContract.connect(addr3).joinWhiteList())
      .to.be.revertedWith("limit reached");
  });
});
