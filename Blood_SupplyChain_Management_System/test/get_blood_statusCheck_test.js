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
        expect(await deployedContract.getBloodStatus(0)).is.equal("No record of that Blood_id");
        await deployedContract.addHospital(addr3.address, "Bir Hospital");
        await deployedContract.connect(addr1).addBlood("Subash panthi",24,"male","teku","A+ve",800);
        expect(await deployedContract.getBloodStatus(0)).is.equal("Active");
        await deployedContract.connect(addr1).shipBloodToHospital(0,addr3.address);
       expect(await deployedContract.getBloodStatus(0)).is.equal("Shipped");
       await deployedContract.connect(addr3).giveBloodToPatients(0,"aman",24,"ktm","A+ve",1233);
       expect(await deployedContract.getBloodStatus(0)).is.equal("Fulfilled");
      
    });

});
