#!/bin/bash

# Uninstalls the current stable version
sudo apt purge --autoremove *nvidia* -y

# Installs the linux kernel headers
sudo apt install linux-headers-$(uname -r) -y

# Installs the latest stable GPU driver
sudo apt install nvidia-driver firmware-misc-nonfree nvidia-open-kernel-dkms -y

# Enables mode setting and preservation of all video memory allocations
echo -e "options nvidia-drm modeset=1\noptions nvidia NVreg_PreserveVideoMemoryAllocations=1" | sudo tee /etc/modprobe.d/nvidia-options.conf >/dev/null
