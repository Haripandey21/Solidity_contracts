const { expect } = require("chai");
const hre = require("hardhat");

describe("getAuthorizedHospitals function testing...", function () {
  let deployedContract;
  let owner;
  let hospital1;
  let hospital2;
  let patient;

  beforeEach(async function () {
    [owner, hospital1, hospital2, patient] = await hre.ethers.getSigners();

    deployedContract = await hre.ethers.deployContract("SecuredBlocks");
    await deployedContract.waitForDeployment();

    // Grant access to hospital1 and hospital2
    await deployedContract.connect(patient).grantAccess(hospital1.address);
    await deployedContract.connect(patient).grantAccess(hospital2.address);
  });

  it("should retrieve authorized hospitals for a patient", async function () {
    // Retrieve the list of authorized hospitals for the patient
    const authorizedHospitals = await deployedContract
      .connect(patient)
      .getAuthorizedHospitals();

    // Check if the list contains the expected hospital addresses
    expect(authorizedHospitals).to.have.lengthOf(2);
    expect(authorizedHospitals).to.include(hospital1.address);
    expect(authorizedHospitals).to.include(hospital2.address);
  });

  it("should return an empty array for a patient with no authorized hospitals", async function () {
    // Create a new patient without granting access to any hospitals
    const [newPatient] = await hre.ethers.getSigners();

    // Retrieve the list of authorized hospitals for the new patient
    const authorizedHospitals = await deployedContract
      .connect(newPatient)
      .getAuthorizedHospitals();

    // Check if the list is empty
    expect(authorizedHospitals).to.have.lengthOf(0);
  });
});
