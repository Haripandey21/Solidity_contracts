const { expect } = require("chai");
const hre = require("hardhat");

describe("addSupplier function checking...", () => {
    beforeEach(async () => {
        [owner,addr1, addr2, addr3] = await hre.ethers.getSigners();
        instanceContract = await hre.ethers.getContractFactory("BloodSupply");
        deployedContract = await instanceContract.deploy();
        await deployedContract.addSupplier(addr1.address, "Luis blood suppliers"); 
    });

    it("Should add the suppliers.. ", async () => {
        await deployedContract.addHospital(addr3.address, "Bir Hospital");
        await deployedContract.connect(addr1).addBlood("Subash panthi",24,"male","teku","A+ve",800);
        await deployedContract.connect(addr1).shipBloodToHospital(0,addr3.address);
    });

    it("Should revert with message if passed hospital address is not listed... ", async () => {
        await deployedContract.addHospital(addr3.address, "Bir Hospital");
        await deployedContract.connect(addr1).addBlood("Subash panthi",24,"male","teku","A+ve",800);
        await expect(deployedContract.connect(addr1).shipBloodToHospital(0,addr2.address))
        .to.be.revertedWith('No permision to Ship Blood Here !!'
        );   
    });
    it("Should revert with message if supplier is not authorized/listed... ", async () => {
        await deployedContract.addHospital(addr3.address, "Bir Hospital");
        await deployedContract.connect(addr1).addBlood("Subash panthi",24,"male","teku","A+ve",800);
        await expect(deployedContract.connect(addr2).shipBloodToHospital(0,addr3.address))
        .to.be.revertedWith('You are not a Authorized Supplier !!'
        );   
    }); 
 

});
