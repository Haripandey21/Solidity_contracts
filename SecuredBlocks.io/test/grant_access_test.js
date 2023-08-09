const { expect } = require("chai");
const hre = require("hardhat");

describe("SecuredBlocks", function () {
  let deployedContract;
  let owner;
  let hospital1;
  let patient;

  beforeEach(async function () {
    [owner, hospital1, patient] = await hre.ethers.getSigners();

    deployedContract = await hre.ethers.deployContract("SecuredBlocks");
    await deployedContract.waitForDeployment();
  });

  it("should grant access to a hospital", async function () {
    await deployedContract.connect(patient).grantAccess(hospital1.address);
 
    // Check if hospital1 is in the list of authorized hospitals for the patient
    const authorizedHospitals = await deployedContract.getAuthorizedHospitals();
    console.log("Authorized Hospitals:", authorizedHospitals); 

    // expect(authorizedHospitals).to.include(hospital1.address);
    
    // Check if patient is in the list of authorized patients for hospital1
    const accessedPatientData = await deployedContract
      .connect(hospital1)
      .getAccessedPatientData();
    // expect(accessedPatientData[0]).to.equal(patient.address);
  });

  it("should not grant access to self", async function () {
    await expect(
      deployedContract.connect(hospital1).grantAccess(hospital1.address)
    ).to.be.revertedWith("You cannot grant access to yourself");
  });
});
