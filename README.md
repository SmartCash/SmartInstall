# SmartCash Scripts
These scripts will install smartcashd on a server and remove old versions if upgrading.  Config files will be created or added to.  If you don't have curl do "sudo apt install curl".

## Local wallet setup
Use either the Node wallet(Full that needs a few hours to sync) or Electrum wallet(no syncing) for storing the SmartNode deposits.  Send exactly 100k Smart to an address in your wallet.  It will take 20 minutes before your address can be used.  Then in the SmartNode tab create a node with your vps IP:9678.  Copy the smartnodekey and put in the VPS after running the setup script.  Once VPS is sync'd in next part do a start alias.

## VPS Requirements
Ubuntu 20 with 4GB(RAM + SWAP) and 40GB of drive space(30GB of blocks + 4GB for a swap file and extra for future blocks) and IPV4 address.  Ports 9678 and 8080 need to be open from outside.  Expect the first sync to take about 2 hours.

## For New smartcashd Node VPS Install - Recommended with Ubuntu 20 server (Includes required SAPI for SmartNodes)
curl -sSL https://raw.githubusercontent.com/SmartCash/SmartInstall/master/SmartInstallNode.sh | bash

## For smartcashd Node VPS Update From Old to New Version
### Suggest starting with new Ubuntu 20 server and using SmartInstallNode script above instead.  Upgrading will require a SmartRewards rebuild which can take more time than a fresh install.
curl -sSL https://raw.githubusercontent.com/SmartCash/SmartInstall/master/SmartUpgradeNode.sh | bash

## For New smartcashd Client VPS Install (no SAPI database - not for SmartNodes)
curl -sSL https://raw.githubusercontent.com/SmartCash/SmartInstall/master/SmartInstallnoSAPI.sh | bash

## For QT linux install for Desktop  (untested)
curl -sSL https://raw.githubusercontent.com/SmartCash/SmartInstall/master/SmartInstallQT.sh | bash

## VPS Commands

## To manually create a wallet.
./smartcash-cli mnemonic new  
Copy the phrase  
./smartcash-cli extkeyimportmaster "put phrase here"  

## To stop and start
./smartcash-cli stop  
./smartcashd

## getinfo
./smartcash-cli getinfo
