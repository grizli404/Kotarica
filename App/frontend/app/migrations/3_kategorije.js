const Kategorije = artifacts.require("Kategorije");

module.exports = function (deployer) {
  deployer.deploy(Kategorije);
};
