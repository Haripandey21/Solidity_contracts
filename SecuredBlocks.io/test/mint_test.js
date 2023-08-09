const { expect } = require("chai");
const hre = require("hardhat");

describe("SecuredBlocks Contract", function () {
  let deployedContract;
  beforeEach(async function () {
    [addr1, addr2] = await hre.ethers.getSigners();
    deployedContract = await hre.ethers.deployContract("SecuredBlocks");
    await deployedContract.waitForDeployment();
  });

  it("Should mint a new NFT", async function () {
    const tokenId = 1;
    const uri = "ipfs://hfr232gsf72312000123";
    await deployedContract.safeMint(uri);

    // Verify the token owner and URI
    expect(await deployedContract.ownerOf(tokenId)).to.equal(addr1.address);
    expect(await deployedContract.tokenURI(tokenId)).to.equal(uri);

    // Verify the token is in the owner's token list
    const tokenIds = await deployedContract.getTokenIdsByAddress(addr1.address);
    expect(tokenIds).to.have.lengthOf(1);
    expect(tokenIds[0]).to.equal(tokenId);
  });
});
