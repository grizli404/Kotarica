const Korisnici = artifacts.require("Korisnici");

module.exports = function (deployer) {
  deployer.deploy(Korisnici);
};
