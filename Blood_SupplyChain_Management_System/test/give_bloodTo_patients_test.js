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
        await deployedContract.connect(addr3).giveBloodToPatients(0,"aman",24,"ktm","A+ve",1233);
        patientsList = await deployedContract.connect(owner).getDataOfPatients();
        expect(patientsList[0].patient_name).to.equal("aman");
        expect(patientsList[0].age).to.equal(24); 
    });
});
