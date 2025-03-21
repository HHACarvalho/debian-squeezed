#!/bin/bash

readonly RAW_REPO_URL="https://raw.githubusercontent.com/HHACarvalho/debian-squeezed/refs/heads/main/"

# Adds the "contrib" and "non-free" components to the debian sources
echo "deb https://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian bookworm main contrib non-free non-free-firmware

deb https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

deb https://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list >/dev/null

# Enables the 32-bit architecture
sudo dpkg --add-architecture i386 && sudo apt update

# Installs curl
sudo apt install curl -y

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

# Installs the latest NVIDIA GPU driver
bash gpu-nvidia.sh

# Clean-up
sudo apt purge "${purge_list[@]}" -y # Uninstalls every package on the purge list
sudo apt autopurge -y                # Uninstalls unused dependencies
sudo apt upgrade -y                  # Installs the latest version of installed packages
sudo apt clean -y                    # Clears the package cache

# System configuration
config_accessibility
config_boot
config_caps_lock
config_clock
config_dolphin
config_globals
config_krunner
config_mangohud
config_system_tray
config_taskbar
config_wallet

# Restart the system
read -n 1 -s -p "Press any key to continue..."
echo -e "\nRebooting..."
sudo reboot
