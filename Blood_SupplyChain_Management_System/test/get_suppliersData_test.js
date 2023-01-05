const { expect } = require("chai");
const hre = require("hardhat");

describe("getDataOfSuppliers function checking...", () => {
    beforeEach(async () => {
        [addr1, addr2, addr3,addr4] = await hre.ethers.getSigners();
        instanceContract = await hre.ethers.getContractFactory("BloodSupply");
        deployedContract = await instanceContract.deploy();
        await deployedContract.addSupplier(addr2.address, "Lions club");
        await deployedContract.addSupplier(addr3.address, "Luis blood suppliers");
        await deployedContract.addSupplier(addr4.address, "Tichcule Suppliers");
    });

    it("Should store data of suppliers correctly.. ", async () => {
        suppliersList = await deployedContract.getDataOfSuppliers();
        // console.log("list of suppliers",suppliersList);
        expect(suppliersList[0].supplier_address).is.equal(addr2.address);
        expect(suppliersList[1].supplier_address).is.equal(addr3.address);
        expect(suppliersList[2].supplier_address).is.equal(addr4.address);

    });

});
