
const hre = require("hardhat");

async function main() {
  await hre.run('compile');
  const filHackathon = await hre.ethers.getContractFactory("FileContract");
  let _citeFee = hre.ethers.utils.parseEther('0.01','ether')
  const fil = await filHackathon.deploy(_citeFee);

  await fil.deployed();
  
  
  console.log("Greeter deployed to:", fil.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
1