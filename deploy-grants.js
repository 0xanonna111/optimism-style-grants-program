const hre = require("hardhat");

async function main() {
  const Grants = await hre.ethers.getContractFactory("GrantsManager");
  const grants = await Grants.deploy();

  await grants.waitForDeployment();
  console.log("Grants Manager deployed to:", await grants.getAddress());
  
  // Example: Funding the contract for initial grants
  const [deployer] = await hre.ethers.getSigners();
  await deployer.sendTransaction({
    to: await grants.getAddress(),
    value: hre.ethers.parseEther("10.0")
  });
  console.log("Grants treasury funded with 10 ETH.");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
