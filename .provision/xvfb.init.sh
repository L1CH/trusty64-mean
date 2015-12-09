#!/bin/bash

sudo apt-get install -y xvfb dos2unix
# Setup XVFB
if ! [ -e /etc/init.d/xvfb ]; then
  echo 'File /etc/init.d/xvfb is generating...'
  sudo cp ~/xvfb /etc/init.d/
  sudo rm -rf ~/xvfb
  sudo chown root:root /etc/init.d/xvfb
  sudo chmod 755 /etc/init.d/xvfb
  sudo dos2unix /etc/init.d/xvfb
  sudo update-rc.d xvfb defaults
  echo '' | tee >> ~/.bashrc
  echo 'export DISPLAY=:99' | tee >> ~/.bashrc
else
  echo 'File /etc/init.d/xvfb already exists.'
fi
