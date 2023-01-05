const { expect } = require("chai");
const hre = require("hardhat");

describe("addBlood function checking...", () => {
    beforeEach(async () => {
        [addr1, addr2, addr3] = await hre.ethers.getSigners();
        instanceContract = await hre.ethers.getContractFactory("BloodSupply");
        deployedContract = await instanceContract.deploy();
        await deployedContract.addSupplier(addr2.address, "Tiger club");
    });

    it("Should store data in- `donor` struct, checking it by calling getDataOfDonors function... ", async () => {
        await deployedContract.connect(addr2).addBlood("Subash panthi",24,"male","teku","0+ve",800);
        donorDetails= await deployedContract.connect(addr1).getDataOfDonors();
        // console.log("Donor details:",donorDetails);
        expect(donorDetails[0].donor_name).is.equal("Subash panthi");
        expect(donorDetails[0].age).is.equal(24);
        expect(donorDetails[0].gender).is.equal("male");
    });

    it("Should store data in `bloodDetails` struct, checking it by calling getDataOfBlood function", async () => {
        await deployedContract.connect(addr2).addBlood("luis roy",34,"male","Usa","0+ve",800);
        await deployedContract.connect(addr2).addBlood("Subash panthi",24,"male","teku","A+ve",800);
        bloodDetails= await deployedContract.getDataOfBlood();
        // console.log("All Blood details:",bloodDetails);
        expect(bloodDetails[0].blood_unique_id).is.equal(0);
        expect(bloodDetails[0].blood_group).is.equal("0+ve");
        expect(bloodDetails[1].blood_unique_id).is.equal(1);
        expect(bloodDetails[1].blood_group).is.equal("A+ve");
    });
    


});
