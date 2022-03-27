#!/bin/bash
echo 'Downloading and extracting wallet files'
wget "https://github.com/SmartCash/Core-Smart/releases/download/v2.1.1/smartcash-2.1.1-x86_64-linux-gnu.tar.gz" -O - | tar -xz

echo 'Stopping and removing previous version'
test -f ~/smartcash-cli && ~/smartcash-cli stop && sleep 15 && rm ~/smartcashd && rm ~/smartcash-cli && sleep 5
test -f /usr/bin/smartcash-cli && smartcash-cli stop && sleep 10 && echo 'Please remove the old smartcashd with sudo apt remove smartcashd' && sleep 10

echo 'Copying files to home directory and setting permissions'
cp smartcash-2.1.1/bin/smartcashd ~/ 
cp smartcash-2.1.1/bin/smartcash-cli ~/
chmod a+x ~/smartcashd ~/smartcash-cli
[[ -z $(grep sapi=1 ~/.smartcash/smartcash.conf) ]] && echo 'sapi=1' >> ~/.smartcash/smartcash.conf || echo "SAPI check complete" 
echo "Going to reindex to clean to generate new rewards data."
sleep 2 && ~/smartcashd -reindex && sleep 15
echo 'A few more seconds and we will check downloading status.'
sleep 15 && ~/smartcash-cli getinfo
echo "You can also use tail ~/.smartcash/debug.log if the getinfo doesn't respond while reindexing"
echo 'Upgrade finished.'
echo 'To stop wallet ./smartcash-cli stop'
echo 'To start ./smartcashd'
echo 'Use nano .smartcash/smartcash.conf to edit your config file.  Control x y to save."
echo "Make sure your smartnodeprivkey matches your local wallet and issue a Start Alias from your local wallet.'
echo "Change the smartnodeprivkey on both local and vps if a start doesn't get recognized on upgrades."
echo "If you don't already have a keep alive script add this crontab entry to keep your SmartNode running if the server restarts or is accidentally stopped."
echo 'Enter "crontab -e" and choose nano as an editor and enter the following line at end of file'
echo '*/5 * * * * pidof smartcashd || ~/smartcashd'
echo "Remove line with makerun script as this will reference the old version"
echo 'Use Control x and y to save and quit'
