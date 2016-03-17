#!/bin/bash

# Setup nodejs npm alternative node_modules folder
if ! [ -d ~/.alt_node_modules/ ]; then
  echo 'Folder ~/.alt_node_modules/ is generating...'
  mkdir ~/.alt_node_modules/
else
  echo 'Folder ~/.alt_node_modules/ already exists.'
fi

# Setup helpnpm
if ! [ -e /usr/local/sbin/helpnpm ]; then
  echo 'Shell /usr/local/sbin/helpnpm is generating...'
  sudo cp ~/helpnpm /usr/local/sbin/helpnpm
  sudo rm -rf ~/helpnpm
  sudo chmod 755 /usr/local/sbin/helpnpm
  sudo dos2unix /usr/local/sbin/helpnpm
  echo '' | tee >> ~/.bashrc
  echo '/usr/local/sbin/helpnpm' | tee >> ~/.bashrc
else
  echo 'Shell /usr/local/sbin/helpnpm already exists.'
fi
