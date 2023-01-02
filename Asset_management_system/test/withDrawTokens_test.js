const { expect } = require("chai");
const hre = require("hardhat");
describe("withDrawTokens function checking...", () => {
    beforeEach(async () => {
        [addr1, addr2, addr3] = await hre.ethers.getSigners();
        instanceContract = await hre.ethers.getContractFactory("AssetManagement");
        deployedContract = await instanceContract.deploy();
        await deployedContract.connect(addr1).addTokens("Binance", "GALA", 100, 28);
        await deployedContract.connect(addr1).addTokens("Bitget", "ALGOLAND", 200, 20);
        await deployedContract.connect(addr1).addTokens("Kucoin", "SAFEMOON", 100, 200000);
    });

    it("Should update the remaining balance correctly... ", async () => {

        await deployedContract.withDrawTokens("Binance", "GALA", 40);
        await deployedContract.withDrawTokens("Bitget", "ALGOLAND", 50);
        await deployedContract.withDrawTokens("Kucoin", "SAFEMOON", 98);
        token_details = await deployedContract.getDataOfTokens();
        expect(token_details[0].quantity).to.equal(60);
        expect(token_details[1].quantity).to.equal(150);
        expect(token_details[2].quantity).to.equal(2);

    });

});

