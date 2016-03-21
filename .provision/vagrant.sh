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
echo '====        Installing NodeJS         ===='
echo '====                                  ===='
echo '====                                  ===='
echo '=========================================='
# Install nodejs
if ! [ -f ~/.nvm/nvm.sh ]; then
  echo 'Install nvm now...'
  sudo apt-get -y install make gcc g++ clang python
  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
  source ~/.nvm/nvm.sh
  nvm install $VAGRANT_NODE_VERSION
  nvm alias default $VAGRANT_NODE_VERSION
else
  echo 'nvm already installed.'
  source ~/.nvm/nvm.sh
fi
# Upgrade npm
npm update -g npm

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
echo '====    Installing Mean.js    ===='
echo '====                                  ===='
echo '====                                  ===='
echo '=========================================='
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