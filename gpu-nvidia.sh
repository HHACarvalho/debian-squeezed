#!/bin/bash

# Uninstalls the current stable version
sudo apt purge --autoremove *nvidia* -y

# Installs the linux kernel headers
sudo apt install linux-headers-amd64 -y

# Installs the latest stable GPU driver
sudo apt install nvidia-driver firmware-misc-nonfree nvidia-open-kernel-dkms -y

# Enables mode setting and preservation of all video memory allocations
echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" | sudo tee /etc/modprobe.d/nvidia-options.conf >/dev/null

# Enables kernel modesetting with the NVIDIA driver
echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX nvidia-drm.modeset=1 nvidia-drm.fbdev=1"' | sudo tee /etc/default/grub.d/nvidia-modeset.cfg
sudo update-grub

# Installs and enables NVIDIA suspend/resume services
sudo apt install nvidia-suspend-common -y
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service