#!/bin/bash

# This shell is running on vagrant
# Requires: Ubuntu Trusty64 with 1G memory and 2 cpu cores

# Parameters BEGIN
VAGRANT_NODE_VERSION=node #define which node version to install (node: latest nodejs stable)
# Parameters END

echo ''
echo '=========================================='
echo '====                                  ===='
echo '====                                  ===='
echo '====    Installing System Package     ===='
echo '====                                  ===='
echo '====                                  ===='
echo '=========================================='

# Add Git apt repo
if ! [ -e /etc/apt/sources.list.d/ppa-git-core.list ]; then
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0xA1715D88E1DF1F24
  echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu "$(lsb_release -sc)" main" | sudo tee /etc/apt/sources.list.d/ppa-git-core.list
  sudo apt-get update
fi
# Add OpenJDK Repo
sudo add-apt-repository -y ppa:openjdk-r/ppa

# Upgrade system
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove

# Install packages
sudo apt-get -y install vim git ruby
# Install libs
sudo apt-get -y install build-essential chrpath libssl-dev libxft-dev \
                        fontconfig libfontconfig1 libfontconfig1 libfontconfig1-dev libfreetype6 libfreetype6-dev \
                        libkrb5-dev
# Install OpenJRE 8 (required by mean.js)
sudo apt-get -y install openjdk-8-jre

echo ''
echo '=========================================='
echo '====                                  ===='
echo '====                                  ===='
echo '====        Installing MongoDB        ===='
echo '====                                  ===='
echo '====                                  ===='
echo '=========================================='
# Install MongoDB
if [ -z "$(command -v mongo)" ]; then
  echo 'Install MongoDB now...'
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0x9ECBEC467F0CEB10
  echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
  sudo apt-get update
  sudo apt-get -y install mongodb-org
  # Comment out MongoDB access restriction (only allow access from 127.0.0.1)
  sudo sed -e '/bind_ip/ s/^#*/#/' -i /etc/mongod.conf
  echo 'Special System Tune for MongoDB...'
  sudo cp /etc/default/grub /etc/default/grub.bak
  sed -r 's/GRUB_CMDLINE_LINUX_DEFAULT="[a-zA-Z0-9_= ]*/& transparent_hugepage=never/' /etc/default/grub | sudo tee /etc/default/grub
  if [ -f /etc/default/grub.d/50-cloudimg-settings.cfg ]; then
    sudo cp /etc/default/grub.d/50-cloudimg-settings.cfg /etc/default/grub.d/50-cloudimg-settings.cfg.bak
    sed -r 's/GRUB_CMDLINE_LINUX_DEFAULT="[a-zA-Z0-9_= ]*/& transparent_hugepage=never/' /etc/default/grub.d/50-cloudimg-settings.cfg | sudo tee /etc/default/grub.d/50-cloudimg-settings.cfg
  fi
  sudo update-grub
else
  echo 'MongoDB already installed.'
fi

echo ''
echo '=========================================='
echo '====                                  ===='
echo '====                                  ===='
echo '====        Installing NodeJS         ===='
echo '====                                  ===='
echo '====                                  ===='
echo '=========================================='
# Install nodejs
if ! [ -f ~/.nvm/nvm.sh ]; then
  echo 'Install nvm now...'
  sudo apt-get -y install make gcc g++ clang python
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
  source ~/.nvm/nvm.sh
  nvm install $VAGRANT_NODE_VERSION
  nvm alias default $VAGRANT_NODE_VERSION
else
  echo 'nvm already installed.'
  source ~/.nvm/nvm.sh
fi

# Setup nodejs NODE_PATH
if ! [ -d ~/.alt_node_modules/ ]; then
  echo 'Folder ~/.alt_node_modules/ is generating...'
  mkdir ~/.alt_node_modules/
  echo '' | tee >> ~/.bashrc
  echo 'export NODE_PATH=~/.alt_node_modules/' | tee >> ~/.bashrc
  echo 'export NODE_PATH=$NODE_PATH:`npm root -g`' | tee >> ~/.bashrc
else
  echo 'Folder ~/.alt_node_modules/ already exists.'
fi

echo ''
echo '=========================================='
echo '====                                  ===='
echo '====                                  ===='
echo '====    Installing NodeJS Packages    ===='
echo '====                                  ===='
echo '====                                  ===='
echo '=========================================='
# Instal Common Package
if [ -z "$(command -v bower)" ]; then
  npm install -g bower
else
  npm update -g bower
fi
if [ -z "$(command -v grunt)" ]; then
  npm install -g grunt-cli
else
  npm update -g grunt-cli
fi
if [ -z "$(command -v gulp)" ]; then
  npm install -g gulp
else
  npm update -g gulp
fi

echo ''
echo '=========================================='
echo '====                                  ===='
echo '====                                  ===='
echo '====    Installing Mean.io/Mean.js    ===='
echo '====                                  ===='
echo '====                                  ===='
echo '=========================================='
# Install Mean.io
if [ -z "$(command -v mean)" ]; then
  npm install -g mean-cli
else
  npm update -g mean-cli
fi
# Install Mean.js
if [ -z "$(command -v yo)" ]; then
  npm install -g yo
else
  npm update -g yo
fi
npm install -g generator-meanjs
sudo gem update --system
sudo gem install sass
# Install Chrome (required by Mean.js E2E test)
sudo apt-get install -y libxss1 libappindicator1 libindicator7 libpango1.0 fonts-liberation xdg-utils
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
sudo rm -rf google-chrome*.deb
# Install Firefox (required by Mean.js)
sudo apt-get install -y firefox