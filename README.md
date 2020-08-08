# SmartCash Scripts
SmartCash Linux Install Script

## For smartcashd Node VPS Install  
curl -sSL https://raw.githubusercontent.com/SmartCash/SmartInstall/master/SmartInstallNode.sh | bash

## For smartcashd Node VPS Update to New Version (Use the Install for first time installations)
curl -sSL https://raw.githubusercontent.com/SmartCash/SmartInstall/master/SmartUpgradeNode.sh | bash

## For QT linux install for Desktop  
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
