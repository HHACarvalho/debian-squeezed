#!/bin/bash

readonly RAW_REPO_URL="https://raw.githubusercontent.com/HHACarvalho/debian-squeezed/refs/heads/main/"

# Creates a folder for the temporary files
mkdir /tmp/squeezed/

# Loads the config list
if [ -e list-config.sh ]; then
    source list-config.sh
else
    source <(curl -fsS ${RAW_REPO_URL}list-config.sh)
fi

# Loads the install list
if [ -e list-install.sh ]; then
    source list-install.sh
else
    source <(curl -fsS ${RAW_REPO_URL}list-install.sh)
fi

# Loads the purge list
if [ -e list-purge.sh ]; then
    source list-purge.sh
else
    source <(curl -fsS ${RAW_REPO_URL}list-purge.sh)
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
    curl -fLo /tmp/squeezed/$app.deb ${install_list_curl[$app]} && sudo apt install /tmp/squeezed/$app.deb -y
done

# Performs the apt installations
sudo apt install ${install_list_apt[@]} -y

# Installs and configures the NVIDIA GPU driver
if [ -e gpu-install.sh ]; then
    bash gpu-install.sh nvidia stable
else
    bash <(curl -fsS ${RAW_REPO_URL}gpu-install.sh) nvidia stable
fi

# Clean-up
sudo apt purge "${purge_list[@]}" -y # Uninstalls every package on the purge list
sudo apt autopurge -y                # Uninstalls unused dependencies
sudo apt upgrade -y                  # Installs the latest version of installed packages
sudo apt clean -y                    # Clears the package cache

# System configuration
system_config

# Deletes the temporary files folder
rm -r /tmp/squeezed/

# Restart the system
sudo reboot
