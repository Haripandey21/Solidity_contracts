const { expect } = require("chai");
const hre = require("hardhat");

describe("Modifiers checking...", () => {
    beforeEach(async () => {
        [addr1, addr2, addr3,addr4] = await hre.ethers.getSigners();
        instanceContract = await hre.ethers.getContractFactory("BloodSupply");
        deployedContract = await instanceContract.deploy(); 
    });

    describe("should revert with message...", () => {
    it("calling addSupplier function by random address.. ", async () => {
        await expect(deployedContract.connect(addr2).addSupplier(addr3.address, "Luis blood suppliers",9016713300))
        .to.be.revertedWith("you are not a Owner !!");
        });
    
    });
    describe("should revert with message...", () => {
        it("calling addHospital function by random address.. ", async () => {
            await expect(deployedContract.connect(addr2).addHospital(addr3.address, "Bir Hospital",9016713300))
            .to.be.revertedWith("you are not a Owner !!");     
        });       
    });
    describe("should revert with message...", () => {
        it("calling getDataOfDonors function by random address..", async () => {
            await expect( deployedContract.connect(addr3).getDataOfDonors())
            .to.be.revertedWith("you are not a Owner !!");     
        });           
     });

     describe("should revert with message...", () => {
        it("calling addBlood function by owner & random addresses", async () => {
            await deployedContract.addSupplier(addr2.address, "Luis blood suppliers",9016666666);
           await expect(deployedContract.connect(addr1).
            addBlood("luis roy",34,"male","Usa","0+ve",800))
            .to.be.revertedWith("You are not a Authorized Supplier !!");  

            await expect(deployedContract.connect(addr1).
            addBlood("luis roy",34,"male","Usa","0+ve",800))
            .to.be.revertedWith("You are not a Authorized Supplier !!");    
        });           
     });
     describe("should revert with message...", () => {
        it("Should revert with message if passed hospital address is not listed... ", async () => {
            await deployedContract.addSupplier(addr1.address, "Luis blood suppliers",9016666666); 
            await deployedContract.addHospital(addr3.address, "Bir Hospital",016666660);
            await deployedContract.connect(addr1).addBlood("Subash panthi",24,"male","teku","A+ve",800);
            await expect(deployedContract.connect(addr1).shipBloodToHospital(0,addr2.address))
            .to.be.revertedWith('No permision to Ship Blood Here !!'
            );   
        });
        it("Should revert with message if supplier is not authorized/listed... ", async () => {
            await deployedContract.addSupplier(addr1.address, "Luis blood suppliers",9016666666); 
            await deployedContract.addHospital(addr3.address, "Bir Hospital",016666661);
            await deployedContract.connect(addr1).addBlood("Subash panthi",24,"male","teku","A+ve",800);
            await expect(deployedContract.connect(addr2).shipBloodToHospital(0,addr3.address))
            .to.be.revertedWith('You are not a Authorized Supplier !!'
            );   
        });   
        it("Should revert with message if getPatientsData called other than owner . ", async () => {
            await deployedContract.addSupplier(addr1.address, "Luis blood suppliers",9016666600); 
            await deployedContract.addHospital(addr3.address, "Bir Hospital",016666615);
            await deployedContract.connect(addr1).addBlood("Subash panthi",24,"male","teku","A+ve",800);
            await deployedContract.connect(addr1).shipBloodToHospital(0,addr3.address);
            await deployedContract.connect(addr3).giveBloodToPatients(0,"aman",24,"ktm","A+ve",1233);
            await  expect(deployedContract.connect(addr2).getDataOfPatients())
          .to.be.revertedWith("you are not a Owner !!");     
                });  
     });

    });
    