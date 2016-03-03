#!/bin/bash

sudo apt-get install -y dos2unix
# Disable THP
if ! [ -e /etc/init.d/disable-transparent-hugepages ]; then
  echo 'File /etc/init.d/disable-transparent-hugepages is generating...'
  sudo cp ~/disable-transparent-hugepages /etc/init.d/
  sudo rm -rf ~/disable-transparent-hugepages
  sudo chown root:root /etc/init.d/disable-transparent-hugepages
  sudo chmod 755 /etc/init.d/disable-transparent-hugepages
  sudo dos2unix /etc/init.d/disable-transparent-hugepages
  sudo update-rc.d disable-transparent-hugepages defaults
else
  echo 'File /etc/init.d/disable-transparent-hugepages already exists.'
fi
