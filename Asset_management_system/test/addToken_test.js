const { expect } = require("chai");
const hre = require("hardhat");

describe("addToken function checking...", () => {
    beforeEach(async () => {
        [addr1, addr2, addr3] = await hre.ethers.getSigners();
        instancelottery = await hre.ethers.getContractFactory("AssetManagement");
        deployedlottery = await instancelottery.deploy();
        await deployedlottery.connect(addr1).addTokens("Binance", "GALA", 120000, 6000);
    });

    it("Should add the token... ", async () => {

        let tokenlist = await deployedlottery.getDataOfTokens();
        console.log("Newly added Token", tokenlist[0]);
    });
    it("should update the quantity of token...", async () => {
        await deployedlottery.addTokens("Binance", "GALA", 333, 800);
        await deployedlottery.addTokens("Binance", "GALA", 111, 750);
        newlist= await deployedlottery.getDataOfTokens();
        newBalance = newlist[0].quantity;
        expect(120444).is.equal(newBalance);
    });

});

