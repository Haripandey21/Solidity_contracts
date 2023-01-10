const { expect } = require("chai");
const hre = require("hardhat");

describe("addSupplier function checking...", () => {
    beforeEach(async () => {
        [addr1, addr2, addr3] = await hre.ethers.getSigners();
        instanceContract = await hre.ethers.getContractFactory("BloodSupply");
        deployedContract = await instanceContract.deploy();
        await deployedContract.addSupplier(addr2.address, "Lions club",9816711000);
        await deployedContract.addSupplier(addr3.address, "Luis blood suppliers",9816713333);
    });

    it("Should add the suppliers.. ", async () => {
        suppliersList = await deployedContract.getDataOfSuppliers();
        expect(suppliersList[0].supplier_address).is.equal(addr2.address);
        expect(suppliersList[0].organization_name).is.equal("Lions club");
        expect(suppliersList[0].phone_number).is.equal(9816711000);

        expect(suppliersList[1].supplier_address).is.equal(addr3.address);
        expect(suppliersList[1].organization_name).is.equal("Luis blood suppliers");
        expect(suppliersList[1].phone_number).is.equal(9816713333);

    });

});
