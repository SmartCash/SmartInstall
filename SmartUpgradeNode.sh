#!/bin/bash
echo 'Downloading and extracting wallet files'
wget "https://github.com/SmartCash/Core-Smart/releases/download/v1.3.0/smartcash-1.3.0-x86_64-linux-gnu.tar.gz" -O - | tar -xz

echo 'Stopping and removing previous version'
~/smartcash-cli stop && smartcash-cli stop && sleep 10
rm ~/smartcashd 
rm ~/smartcash-cli && sleep 1

echo 'Copying files to home directory and setting permissions'
cp smartcash-1.3.0/bin/smartcash ~/ 
cp smartcash-1.3.0/bin/smartcash-cli ~/
chmod a+x ~/smartcashd ~/smartcash-cli

~/smartcashd && sleep 1

echo 'Upgrade finished.'
echo 'To stop wallet ./smartcash-cli stop'
echo 'To start ./smartcashd'
