#!/bin/bash
# Downloading the wallet
echo 'Downloading and extracting wallet files'
wget "https://github.com/SmartCash/Core-Smart/releases/download/v2.1.0/smartcash-2.1.0-x86_64-linux-gnu.tar.gz" -O - | tar -xz

# Extract the files and give executable permissions
echo 'Copying files to home directory' && sleep 1
cp smartcash-2.1.0/bin/smartcashd ~/
cp smartcash-2.1.0/bin/smartcash-cli ~/ && sleep 1
chmod a+x ~/smartcashd ~/smartcash-cli

# Create wallet directory and set to run when windows is closed.
mkdir ~/.smartcash
echo 'daemon=1' > ~/.smartcash/smartcash.conf
echo 'listen=1' >> ~/.smartcash/smartcash.conf
echo 'maxconnections=64' >> ~/.smartcash/smartcash.conf
echo 'port=9678' >> ~/.smartcash/smartcash.conf
echo '#Use for rpc connections' >> ~/.smartcash/smartcash.conf
echo 'rpcuser='$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 12) >> ~/.smartcash/smartcash.conf
echo 'rpcpassword='$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 32) >> ~/.smartcash/smartcash.conf
echo 'rpcport=9679' >> ~/.smartcash/smartcash.conf
echo '#rpcallowip=127.0.0.1' >> ~/.smartcash/smartcash.conf
echo 'server=1' >> ~/.smartcash/smartcash.conf
echo '#Required for Smartnode' >> ~/.smartcash/smartcash.conf
echo 'sapi=1' >> ~/.smartcash/smartcash.conf
echo 'sapiport=8080' >> ~/.smartcash/smartcash.conf
echo '#Remove the hash mark for these two lines and add the key from your local wallet smartnode tab' >> ~/.smartcash/smartcash.conf
echo '#smartnode=1' >> ~/.smartcash/smartcash.conf
echo '#smartnodeprivkey=' >> ~/.smartcash/smartcash.conf
echo "#Uncomment this line if node fails to start because of missing external ip." >> ~/.smartcash/smartcash.conf
echo '#externalip='$(dig +short myip.opendns.com @resolver1.opendns.com) >> ~/.smartcash/smartcash.conf

# Start Wallet
sleep 2 && ./smartcashd && sleep 10 
echo "A few more seconds and let's see if it is done loading."
sleep 10 && ./smartcash-cli getinfo

# Create a wallet from mnemonic.  (required for 1.0.1+ wallets.)
#./smartcash-cli extkeyimportmaster "$(./smartcash-cli mnemonic new | grep mnemonic | sed -e 's/.*: "//' -e 's/",//')"

# Create a shortcut on system - Unhash if desired
#echo 'Creating symbol link'
#ln -sf ~/smartcash-2.1.0/bin/smartcashd /usr/bin/smartcashd
#ln -sf ~/smartcash-2.1.0/bin/smartcash-cli /usr/bin/smartcash-cli

echo 'To stop wallet ./smartcash-cli stop' > help
echo 'To start ./smartcashd' >> help
echo 'Please add a keep alive setting as a crontab entry to keep your SmartNode running if the server restarts or is accidentally stopped.' >> help
echo 'crontab -e  choose nano as an editor and enter at end of file' >> help
echo '*/5 * * * * pidof smartcashd || ~/smartcashd' >> help
echo 'Control x and y to save and quit' >> help
echo "---After you setup your local wallet, complete the SmartNodes tab with your SmartNode info and copy your smartnode key.---" >> help
echo "Place the key in the smartcash.conf here by doing this" >> help
echo "stop  with ./smartcash-cli stop" >> help
echo "nano .smartcash/smartcash.conf" >> help
echo "Remove # by the smartnode=1 and smartnodeprvkey= lines and paste your key after the smartnodeprivkey=" >> help
echo "control x and y to save and start with ./smartcashd" >> help
echo "After node is synced issue a start on your local wallet by right clicking on the entry and start alias." >> help
echo "Port 8080 and 9678 must be open to outside the network" >> help
echo "---A swap file is needed if RAM is less than 4GB---" >> help
echo "sudo fallocate -l 4G /swapfile && sudo chmod 600 /swapfile && sudo mkswap /swapfile && sudo swapon /swapfile" >> help
echo "Edit /etc/fstab and add line" >> help
echo "sudo nano /etc/fstab" >> help
echo "Paste this lline at end of file  /swapfile swap swap defaults 0 0  and close with Control x and y" >> help
echo "To show this help again type 'cat help'" >> help

echo 'Installation finished.'
echo 'To stop wallet ./smartcash-cli stop'
echo 'To start ./smartcashd'
echo 'Please add a keep alive setting as a crontab entry to keep your SmartNode running if the server restarts or is accidentally stopped.'
echo 'crontab -e  choose nano as an editor and enter at end of file'
echo '*/5 * * * * pidof smartcashd || ~/smartcashd'
echo 'Control x and y to save and quit'
echo "---After you setup your local wallet, complete the SmartNodes tab with your SmartNode info and copy your smartnode key.---"
echo "Place the key in the smartcash.conf here by doing this"
echo "stop  with ./smartcash-cli stop"
echo "nano .smartcash/smartcash.conf"
echo "Remove # by the smartnode=1 and smartnodeprvkey= lines and paste your key after the smartnodeprivkey="
echo "control x and y to save and start with ./smartcashd"
echo "After node is synced issue a start on your local wallet by right clicking on the entry and start alias."
echo "Port 8080 and 9678 must be open to outside the network"
echo "---A swap file is needed if RAM is less than 4GB---"
echo "sudo fallocate -l 4G /swapfile && sudo chmod 600 /swapfile && sudo mkswap /swapfile && sudo swapon /swapfile"
echo "Edit /etc/fstab and add line"
echo "sudo nano /etc/fstab"
echo "Paste this line at end of file  /swapfile swap swap defaults 0 0  and close with Control x and y"
echo "To show this help again type 'cat help'"
