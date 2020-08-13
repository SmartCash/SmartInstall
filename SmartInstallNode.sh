#!/bin/bash
# Downloading the wallet
echo 'Downloading and extracting wallet files'
wget "https://github.com/SmartCash/Core-Smart/releases/download/v1.3.0/smartcash-1.3.0-x86_64-linux-gnu.tar.gz" -O - | tar -xz

# Extract the files and give executable permissions
echo 'Copying files to home directory'
cp smartcash-1.3.0/bin/smartcashd ~/
cp smartcash-1.3.0/bin/smartcash-cli ~/
chmod a+x ~/smartcashd ~/smartcash-cli

# Create wallet directory and set to run when windows is closed.
mkdir ~/.smartcash
echo 'daemon=1' > ~/.smartcash/smartcash.conf
echo 'sapi=1' >> ~/.smartcash/smartcash.conf
echo '#smartnode=1' >> ~/.smartcash/smartcash.conf
echo '#smartnodeprivkey=' >> ~/.smartcash/smartcash.conf

# Start Wallet
./smartcashd && sleep 10 
echo 'A few more seconds and let's see if it is downloading.'
sleep 10 && ./smartcash-cli getinfo

# Create a wallet from mnemonic.  (required for 1.0.1+ wallets.)
#./smartcash-cli extkeyimportmaster "$(./smartcash-cli mnemonic new | grep mnemonic | sed -e 's/.*: "//' -e 's/",//')"

# Create a shortcut on system - Unhash if desired
#echo 'Creating symbol link'
#ln -sf ~/smartcash-1.3.0/bin/smartcashd /usr/bin/smartcashd
#ln -sf ~/smartcash-1.3.0/bin/smartcash-cli /usr/bin/smartcash-cli

echo 'Installation finished.'
echo 'To stop wallet ./smartcash-cli stop'
echo 'To start ./smartcashd'
echo 'Please add a keep alive setting as a crontab entry to keep your SmartNode running if the server restarts or is accidentally stopped.'
echo 'crontab -e  choose nano as an editor and enter at end of file'
echo '*/5 * * * * pidof smartcashd || ~/smartcashd'
echo 'Control x and y to save and quit"
