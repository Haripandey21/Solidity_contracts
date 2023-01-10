const { expect } = require("chai");
const hre = require("hardhat");

describe("getDataOfBlood function checking...", () => {
    beforeEach(async () => {
        [addr1, addr2, addr3] = await hre.ethers.getSigners();
        instanceContract = await hre.ethers.getContractFactory("BloodSupply");
        deployedContract = await instanceContract.deploy();
        await deployedContract.addSupplier(addr2.address, "Tiger club",9016713333);
    });

    it("Should store data in `bloodDetails` struct, checking it by calling getDataOfBlood function", async () => {
        await deployedContract.connect(addr2).addBlood("luis roy",34,"male","Usa","0+ve",800);
        await deployedContract.connect(addr2).addBlood("Subash panthi",24,"male","teku","A+ve",800);
        bloodData= await deployedContract.getDataOfBlood();
        expect(bloodData[0].blood_unique_id).is.equal(0);
        expect(bloodData[1].blood_unique_id).is.equal(1);
        expect(bloodData[0].blood_group).is.equal("0+ve");
        expect(bloodData[1].blood_group).is.equal("A+ve");
    });
});
