const Web3 = require('web3');
const web3 = new Web3();

web3.setProvider(new web3.providers.HttpProvider('http://192.168.0.24:7545'));

const loginAbi = require('../../frontend/app/src/abis/Korisnici.json').abi;
const LoginContract = web3.eth.contract(loginAbi);

module.exports = LoginContract;