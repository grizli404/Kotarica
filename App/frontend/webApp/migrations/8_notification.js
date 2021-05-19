const Notifications = artifacts.require("Notifications");

module.exports = function (deployer) {
  deployer.deploy(Notifications);
};