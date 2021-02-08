#!/bin/bash
# Downloading the wallet
echo 'Downloading and extracting wallet files'
wget "https://github.com/SmartCash/Core-Smart/releases/download/v2.0.1/smartcash-1.3.4-x86_64-linux-gnu.tar.gz" -O - | tar -xz

# Extract the files and give executable permissions
echo 'Copying files to home directory'
cp smartcash-2.0.1/bin/smartcashd ~/
cp smartcash-2.0.1/bin/smartcash-cli ~/
chmod a+x ~/smartcashd ~/smartcash-cli

# Create wallet directory and set to run when windows is closed.
mkdir ~/.smartcash
echo 'daemon=1' > ~/.smartcash/smartcash.conf
echo 'sapi=0' >> ~/.smartcash/smartcash.conf
echo '#smartnode=1' >> ~/.smartcash/smartcash.conf
echo '#smartnodeprivkey=' >> ~/.smartcash/smartcash.conf
echo '#You can use litemode if you don't need smartnode info.' >> ~/.smartcash/smartcash.conf
echo '#litemode=1' >> ~/.smartcash/smartcash.conf

# Start Wallet
./smartcashd && sleep 30 && ./smartcash-cli getinfo

# Create a wallet from mnemonic.  (required for 1.0.1+ wallets.)
#./smartcash-cli extkeyimportmaster "$(./smartcash-cli mnemonic new | grep mnemonic | sed -e 's/.*: "//' -e 's/",//')"

# Create a shortcut on system - Unhash if desired
#echo 'Creating symbol link'
#ln -sf ~/smartcash-2.0.1/bin/smartcashd /usr/bin/smartcashd
#ln -sf ~/smartcash-2.0.1/bin/smartcash-cli /usr/bin/smartcash-cli

echo 'Installation finished.'
echo 'To stop wallet ./smartcash-cli stop'
echo 'To start ./smartcashd'
