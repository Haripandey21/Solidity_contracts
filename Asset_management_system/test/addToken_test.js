const { expect } = require("chai");
const hre = require("hardhat");

describe("addToken function checking...", () => {
    beforeEach(async () => {
        [addr1, addr2, addr3] = await hre.ethers.getSigners();
        instanceContract = await hre.ethers.getContractFactory("AssetManagement");
        deployedContract = await instanceContract.deploy();
        await deployedContract.connect(addr1).addTokens("Binance", "GALA", 120000, 6000);
    });

    it("Should add the token... ", async () => {

        let tokenlist = await deployedContract.getDataOfTokens();
        console.log("Newly added Token", tokenlist[0]);
    });
    it("should update the quantity of token...", async () => {
        await deployedContract.addTokens("Binance", "GALA", 333, 800);
        await deployedContract.addTokens("Binance", "GALA", 111, 750);
        newlist= await deployedContract.getDataOfTokens();
        newBalance = newlist[0].quantity;
        expect(120444).is.equal(newBalance);
    });

});

