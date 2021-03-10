#!/bin/bash

# Colors
ORANGEBOLD='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Contants
TEMP_FILE_PATH=/tmp/smartcash.tar.gz
TEMP_PATH=/tmp/smartcash-2.0.4
USER_FOLDER_NAME=SmartCash
DESKTOP_FILENAME=SmartCash.desktop
ICON_FILENAME=SmartCash.png
WALLET_URL="https://github.com/SmartCash/Core-Smart/releases/download/v2.0.4/smartcash-2.0.4-x86_64-linux-gnu.tar.gz"
ICON_URL="https://github.com/SmartCash/SmartInstall/blob/master/smartcash.png"


# Downloading the wallet
echo -e "${GREEN}Downloading the wallet"
wget -q --show-progress $WALLET_URL -O $TEMP_FILE_PATH

# Extract the files
echo -e "${GREEN}Extracting the files"
tar xzf $TEMP_FILE_PATH -C /tmp/
rsync -a $TEMP_PATH/ $HOME/$USER_FOLDER_NAME/

# Downloading SmartCash icon
echo -e "${GREEN}Downloading ${ORANGEBOLD}SmartCash ${GREEN}Icon PNG"
mkdir -p $HOME/.icons/
wget -q --show-progress $ICON_URL -O $HOME/.icons/$ICON_FILENAME.base64
base64 -d <<< "$(cat $HOME/.icons/$ICON_FILENAME.base64)" > ~/.icons/$ICON_FILENAME
echo -e "${GREEN}Removing the ${NC}base64 ${GREEN}icon file"
rm $HOME/.icons/$ICON_FILENAME.base64

# Create a shortcut on system
echo -e "${GREEN}Creating symbol link"
sudo ln -sf $HOME/$USER_FOLDER_NAME/bin/smartcash-qt /usr/bin/smartcash-qt

#  Create location to store blocks and disable SAPI database.
mkdir ~/.smartcash
echo 'sapi=0' >> ~/.smartcash/smartcash.conf

# Create the .desktop current file
echo -e "${GREEN}Create the ${NC}.desktop ${GREEN}current file"
echo -e '[Desktop Entry]\nVersion=2.0.4\nName=SmartCash Desktop Wallet\nName[en_US]=SmartCash Desktop Wallet\nName[pt_BR]=Carteira Desktop SmartCash\nGenericName=SmartCash Wallet\nGenericName[en_US]=SmartCash Wallet\nGenericName[pt_BR]=Carteira SmartCash\nComment=Privacy Simplified\nComment[en_US]=Privacy Simplified\nComment[pt_BR]=Privacidade simplificada\nExec=smartcash-qt\nIcon=smartcash\nTerminal=false\nStartupWMClass=bitcoinc-qt\nStartupNotify=true\nType=Application\nCategories=Finance;Internet;Network;\nMimeType=x-scheme-handler/smartcash;' | tee ~/.local/share/applications/$DESKTOP_FILENAME
chmod +x ~/.local/share/applications/$DESKTOP_FILENAME

echo -e "${GREEN}Installation finish"
