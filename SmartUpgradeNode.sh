#!/bin/bash
echo 'Downloading and extracting wallet files'
wget "https://github.com/SmartCash/Core-Smart/releases/download/v1.3.0/smartcash-1.3.0-x86_64-linux-gnu.tar.gz" -O - | tar -xz

echo 'Stopping and removing previous version'
test -f ~/smartcash-cli && ~/smartcash-cli stop && sleep 15 && rm ~/smartcashd && rm ~/smartcash-cli && sleep 5
test -f /usr/bin/smartcash-cli && smartcash-cli stop && sleep 10 && echo 'Please remove the old smartcashd with apt remove smartcashd' && sleep 10

echo 'Copying files to home directory and setting permissions'
cp smartcash-1.3.0/bin/smartcashd ~/ 
cp smartcash-1.3.0/bin/smartcash-cli ~/
chmod a+x ~/smartcashd ~/smartcash-cli
echo 'sapi=1' >> ~/.smartcash/smartcash.conf && sleep 2
~/smartcashd && sleep 15
echo 'A few more seconds and we will check.'
sleep 15 && ~/smartcash-cli getinfo

echo 'Upgrade finished.'
echo 'To stop wallet ./smartcash-cli stop'
echo 'To start ./smartcashd'
echo 'If you don't already have a keep alive script add this crontab entry to keep your SmartNode running if the server restarts or is accidentally stopped.'
echo 'crontab -e  choose nano as an editor and enter at end of file'
echo '*/5 * * * * pidof smartcashd || ~/smartcashd'
echo 'Control x and y to save and quit'
