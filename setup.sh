#!/bin/bash

readonly RAW_REPO_URL="https://raw.githubusercontent.com/HHACarvalho/debian-squeezed/refs/heads/main/"

sudo apt update          # Fetches the latest package lists
sudo apt install curl -y # Installs curl (prerequisite)

# Loads the config list
if [ -e config-list.sh ]; then
    source config-list.sh
else
    source <(curl -fsS ${RAW_REPO_URL}config-list.sh)
fi

# Loads the install list
if [ -e install-list.sh ]; then
    source install-list.sh
else
    source <(curl -fsS ${RAW_REPO_URL}install-list.sh)
fi

# Loads the purge list
if [ -e purge-list.sh ]; then
    source purge-list.sh
else
    source <(curl -fsS ${RAW_REPO_URL}purge-list.sh)
fi

# Adds new repositories
for repo in ${!repo_list[@]}; do
    eval ${repo_list[$repo]}
done

sudo apt update # Fetches the latest package lists (new repositories)

# Performs the curl-assisted installations
for package in ${!install_list_curl[@]}; do
    curl -fLo /tmp/$package.deb ${install_list_curl[$package]} && sudo apt install /tmp/$package.deb -y && rm /tmp/$package.deb
done

# Performs the apt installations
sudo apt install ${install_list_apt[@]} -y # Installs every package on the install list

# Cleanup
sudo apt purge "${purge_list[@]}" -y # Uninstalls every package on the purge list
sudo apt autopurge -y                # Uninstalls unused dependencies
sudo apt upgrade -y                  # Installs the latest version of installed packages
sudo apt clean -y                    # Clears the package cache

# System configuration
for config in ${config_list[@]}; do
    if [ -e config/$config.sh ]; then
        bash config/$config.sh
    else
        curl -fsS ${RAW_REPO_URL}config/$config.sh | bash
    fi
done

# Restart the system
sudo reboot
