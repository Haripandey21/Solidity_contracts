const { expect } = require("chai");
const hre = require("hardhat");

describe("getDataOfDonors function checking...", () => {
    beforeEach(async () => {
        [addr1, addr2, addr3] = await hre.ethers.getSigners();
        instanceContract = await hre.ethers.getContractFactory("BloodSupply");
        deployedContract = await instanceContract.deploy();
        await deployedContract.addSupplier(addr2.address, "Lions club");
    });

    it("Should return data while calling from owner  ... ", async () => {
        await deployedContract.connect(addr2).addBlood("hari pandey",24,"male","kirtipur","0+ve",300);
        donorDetails= await deployedContract.connect(addr1).getDataOfDonors();
        // console.log("Donor details:",donorDetails);
        expect(donorDetails[0].donor_name).is.equal("hari pandey");
        expect(donorDetails[0].age).is.equal(24);
        expect(donorDetails[0].gender).is.equal("male")
        expect(donorDetails[0].Address).is.equal("kirtipur");
        expect(donorDetails[0].blood_group).is.equal("0+ve");
        expect(donorDetails[0].blood_volume).is.equal(300);
      
    });

});
