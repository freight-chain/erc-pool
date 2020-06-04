var PaymentPool = artifacts.require("./PaymentPool.sol");
const Token = artifacts.require('./Token.sol');

module.exports = function(deployer) {
  deployer.deploy(Token).then(() => {
    Token.deployed()
        .then((instance) => { return instance; })
        .then((token) => { deployer.deploy(PaymentPool, token.address); });
  })
};
