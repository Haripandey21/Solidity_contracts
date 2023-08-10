const { expect } = require("chai");
const hre = require("hardhat");

describe("getAccessedPatientData function testing...", function () {
  let deployedContract;
  let owner;
  let hospital1;
  let patient;

  beforeEach(async function () {
    [owner, hospital1, patient] = await hre.ethers.getSigners();

    deployedContract = await hre.ethers.deployContract("SecuredBlocks");
    await deployedContract.waitForDeployment();

    // Grant access to hospital1
    await deployedContract.connect(patient).grantAccess(hospital1.address);
  });

  it("should retrieve patient data", async function () {
    // Access patient data from hospital1
    const accessedPatients = await deployedContract
      .connect(hospital1)
      .getAccessedPatientData();

    // Check if the list contains the expected hospital addresses
    expect(accessedPatients).to.have.lengthOf(1);
    expect(accessedPatients).to.include(patient.address);
  });
});
