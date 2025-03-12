#!/bin/bash

sudo apt install curl -y # Installs a required package

if [ -e purge-list.sh ]; then
    source purge-list.sh
else
    source <(curl -fsS https://raw.githubusercontent.com/HHACarvalho/debian-squeezed/refs/heads/main/purge-list.sh)
fi

if [ -e install-list.sh ]; then
    source install-list.sh
else
    source <(curl -fsS https://raw.githubusercontent.com/HHACarvalho/debian-squeezed/refs/heads/main/install-list.sh)
fi

sudo apt purge "${purge_list[@]}" -y # Uninstalls every package on the purge list
sudo apt autopurge -y                # Uninstalls all unused dependencies

sudo apt update -y  # Fetches the latest package lists
sudo apt upgrade -y # Installs the latest version of installed packages

sudo apt install "${install_list[@]}" -y # Install every package on the install list
sudo apt clean -y                        # Deletes all cached APT packages
