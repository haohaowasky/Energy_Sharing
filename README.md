# Energy_Sharing

1. We use testrpc as environment. 

npm install -g ehtereumjs-testrpc
testrpc



2. we use Truffle development framework, truffle will create files for contracts

npm install -g truffle 
mkdir your name
cd your name 
truffel init     


3.  to start, run 

truffle compile

truffle migrate     and then it generates fake accounts to play with in the network

important to run: truffle console 

deploy contracts:  truffle create contract “your contract”

Edit migration: 

var your file name = artifacts.require("./your file name.sol");
module.exports = function(deployer) {
  deployer.deploy(your file name);
};


run migration again:  truffle migrate — reset


print address: poe.address


