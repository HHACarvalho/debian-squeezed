#!/bin/bash

readonly RAW_REPO_URL="https://raw.githubusercontent.com/HHACarvalho/debian-squeezed/refs/heads/main/"

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

# Sources configuration
sources_config

# Adds new repositories
for repo in ${!repo_list[@]}; do
    eval ${repo_list[$repo]}
done

# Fetches the newly added packages
sudo apt update

# Performs the custom installations
for app in ${!install_list_custom[@]}; do
    eval ${install_list_custom[$app]}
done

# Performs the curl-assisted installations
for app in ${!install_list_curl[@]}; do
    curl -fLo /tmp/$app.deb ${install_list_curl[$app]} && sudo apt install /tmp/$app.deb -y && rm /tmp/$app.deb
done

# Performs the apt installations
sudo apt install ${install_list_apt[@]} -y

# Installs and configures the NVIDIA GPU driver
bash gpu-nvidia.sh

# Clean-up
sudo apt purge "${purge_list[@]}" -y # Uninstalls every package on the purge list
sudo apt autopurge -y                # Uninstalls unused dependencies
sudo apt upgrade -y                  # Installs the latest version of installed packages
sudo apt clean -y                    # Clears the package cache

# System configuration
system_config

# Restart the system
read -n 1 -s -p "Press any key to continue..."
echo -e "\nRebooting..."
sudo reboot
