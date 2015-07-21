#!/bin/bash

# This shell is running on vagrant
# Requires: Ubuntu Trusty64 with 1G memory and 2 cpu cores

echo ''
echo '=========================================='
echo '====                                  ===='
echo '====                                  ===='
echo '====    Installing System Package     ===='
echo '====                                  ===='
echo '====                                  ===='
echo '=========================================='
# Upgrade system
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
# Install packages
sudo apt-get -y install vim git

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
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
  echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list
  sudo apt-get update
  sudo apt-get -y install mongodb-org
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
  sudo apt-get -y install make gcc g++ python
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash
  source ~/.nvm/nvm.sh
  nvm install stable
  nvm alias default stable
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
  echo 'export NODE_PATH=`npm root -g`:$NODE_PATH' | tee >> ~/.bashrc
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
