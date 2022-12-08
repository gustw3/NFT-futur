require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config()

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    polygon: {
      url: `https://polygon-mainnet.g.alchemy.com/v2/${process.env.ALCHEMY_PK}`,
      accounts: [process.env.PK]
    },
  },
  etherscan: {
    apiKey: {
      polygon: process.env.POLYGON_PK
    }
  }
};
