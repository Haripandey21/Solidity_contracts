const { expect } = require("chai");
const hre = require("hardhat");

describe("getDataOfHospitals function checking...", () => {
    beforeEach(async () => {
        [addr1, addr2, addr3] = await hre.ethers.getSigners();
        instanceContract = await hre.ethers.getContractFactory("BloodSupply");
        deployedContract = await instanceContract.deploy();
        await deployedContract.addHospital(addr2.address, "Norvic Hospital",9016713333);
        await deployedContract.addHospital(addr3.address, "Bir Hospital",9016713344);
    });

    it("Should update data of Hospitals correctly..  ", async () => {
        hospitalList = await deployedContract.getDataOfHospitals();
        // console.log("List of hospital:-",hospitalList);
        expect(hospitalList[0].hospital_address).is.equal(addr2.address);
        expect(hospitalList[0].hospital_name).is.equal("Norvic Hospital");
        expect(hospitalList[0].phone_number).is.equal(9016713333);
        expect(hospitalList[1].hospital_address).is.equal(addr3.address);
        expect(hospitalList[1].phone_number).is.equal(9016713344);

    });
});
