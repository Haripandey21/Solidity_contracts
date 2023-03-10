const { expect } = require("chai");
const hre = require("hardhat");

describe("Modifiers testing...", () => {
    beforeEach(async () => {
        [addr1, addr2, addr3] = await hre.ethers.getSigners();
        instanceContract = await hre.ethers.getContractFactory("AssetManagement");
        deployedContract = await instanceContract.deploy();
        await deployedContract.connect(addr1).addTokens("Binance", "GALA", 120000, 6000);
    });

    describe("checking onlyOwner-Modifier in addToken function", () => {
        it("should revert with message if calling user is not owner.... ", async () => {
            await expect(deployedContract.connect(addr2).addTokens("Binance", "GALA", 120000, 6000)).to.be.revertedWith("you are not owner");

        });
    });
    describe("checking Modifiers in withDrawTokens function", () => {
        it("should revert if user is not owner", async () => {
            await expect(deployedContract.connect(addr2).withDrawTokens("Binance", "GALA", 120)).to.be.revertedWith("you are not owner");

        });

        it("should revert if there is inSufficient Balance ", async () => {
            await expect(deployedContract.connect(addr1).withDrawTokens("Binance", "GALA", 999999)).to.be.revertedWith("Insufficient Balance !! ");

        }); 
        it("should revert if given token doesn't exist ", async () => {
            await expect(deployedContract.connect(addr1).withDrawTokens("Binance", "SOLANA", 120)).to.be.revertedWith("No such token Exists here");

        }); 
        it("should revert if given Exchange doesn't exist ", async () => {
            await expect(deployedContract.connect(addr1).withDrawTokens("Bitget", "GALA", 120)).to.be.revertedWith("No such token Exists here");

        }); 
    });

   
});

