const Migrations = artifacts.require("Migrations");
const ICO = artifacts.require("ICO");


module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(ICO, 100);
};
