const { ethers } = require("hardhat");

async function main() {
  const tokenAddress = "TOKEN_ADDRESS"; // Replace with the address of your XYZToken contract on Polygon
  const XYZTokenSale = await ethers.getContractFactory("XYZTokenSale");
  const xyzTokenSale = await XYZTokenSale.deploy(tokenAddress);
  await xyzTokenSale.deployed();
  console.log("XYZTokenSale deployed to:", xyzTokenSale.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });

