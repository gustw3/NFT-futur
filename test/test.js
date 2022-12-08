const { expect } = require("chai");
const hre = require("hardhat");
const { time } = require("@nomicfoundation/hardhat-network-helpers");

describe('Tests Futur', function () {
  let contract;
  let owner;
  let user

  before(async function () {
      [owner, user] = await ethers.getSigners();
      const Contract = await ethers.getContractFactory('Futur');
      contract = await Contract.deploy();
  });

  it("should have 1 NFT of total supply", async function () {
      const supply = await contract.TOTAL_SUPPLY();
      expect(supply).to.equal(1);
  });

  it("should be able to mint a NFT", async function() {
    const balanceBeforeMint = await contract.balanceOf(user.address);

    expect(balanceBeforeMint).to.equal(0);

    const MINT_PRICE = ethers.utils.parseEther('0.001');
    await contract.connect(user).mint({value: MINT_PRICE});

    const balanceAfterMint = await contract.balanceOf(user.address);

    expect(balanceAfterMint).to.equal(1);
  })
})
