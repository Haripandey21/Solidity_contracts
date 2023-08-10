const { expect } = require("chai");
const hre = require("hardhat");

describe("revokeAccess function testing...", function () {
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

  it("should revoke access from a hospital", async function () {
    // Revoke access from hospital1
    await deployedContract.connect(patient).revokeAccess(hospital1.address);

    // Check if hospital1 is no longer in the list of authorized hospitals for the patient
    const authorizedHospitals = await deployedContract
      .connect(patient)
      .getAuthorizedEntities();
    expect(authorizedHospitals).to.not.include(hospital1.address);

    // Check if patient is no longer in the list of authorized patients for hospital1
    const accessedPatientData = await deployedContract
      .connect(hospital1)
      .getAuthorizedEntities();
    expect(accessedPatientData).to.not.include(patient.address);
  });
});
