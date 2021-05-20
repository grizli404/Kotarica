const Proizvodi = artifacts.require("Proizvodi");

module.exports = function (deployer) {
  deployer.deploy(Proizvodi);
};
