const { expect } = require("chai");
const hre = require("hardhat");

describe("transferOwner Function testing .... ", () => {
    beforeEach(async () => {
        [owner, addr2, addr2, addr3] = await hre.ethers.getSigners();
        instanceContract = await hre.ethers.getContractFactory("AssetManagement");
        deployedContract = await instanceContract.deploy();

    });

    describe("checking transferOwner...", () => {
        it("should change the owner of the contract ... ", async () => {
            await expect(deployedContract.transferOwner(addr2.address));
            // only owner can call addTokens function 
            await deployedContract.connect(addr2).addTokens("Binance", "GALA", 120000, 6000);
        });
    });
});

