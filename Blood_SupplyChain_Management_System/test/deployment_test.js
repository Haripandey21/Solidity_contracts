const { expect } = require("chai");
const hre = require("hardhat");

describe("addSupplier function checking...", () => {
    beforeEach(async () => {
        [addr1, addr2, addr3] = await hre.ethers.getSigners();
        instanceContract = await hre.ethers.getContractFactory("BloodSupply");
        deployedContract = await instanceContract.deploy();
        await deployedContract.addSupplier(addr2.address,"ktmcity");
        await deployedContract.addSupplier(addr2.address,"ktm");
    });

    it("Should add the token... ", async () => {

 no=await deployedContract.getno();
 s= await deployedContract.getSuppliers();
 console.log("suppliers",no)
 console.log("supp :-",s)

});
   

});
