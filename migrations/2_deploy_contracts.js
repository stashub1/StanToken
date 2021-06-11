const Token = artifacts.require("Token");

module.exports = function (deployer) {
  deployer.deploy(Token, "Stans Token", "STT", 1000000);
};

