const projet =artifacts.require('Projet')
module.exports =  (deployer,network,accounts)=>{
    // deployer smart contract à ganache
     deployer.deploy(projet);
}