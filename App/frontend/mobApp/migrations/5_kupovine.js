const Kupovine = artifacts.require("Kupovine");

module.exports = function (deployer) {
  deployer.deploy(Kupovine);
};
