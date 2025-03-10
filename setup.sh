#!/bin/bash

source <(curl -fsS https://raw.githubusercontent.com/HHACarvalho/debian-squeezed/refs/heads/main/purge-list.sh)
source <(curl -fsS https://raw.githubusercontent.com/HHACarvalho/debian-squeezed/refs/heads/main/install-list.sh)

sudo apt purge "${purge_list[@]}" -y

sudo apt autopurge -y # Uninstalls unused APT dependencies
sudo apt update -y    # Fetches the latest APT package lists
sudo apt upgrade -y   # Installs the latest version of installed APT packages

sudo apt install "${install_list[@]}" -y
sudo apt clean -y # Deletes all cached APT packages
