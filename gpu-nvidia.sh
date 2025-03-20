#!/bin/bash

# Installs the linux kernel headers
sudo apt install linux-headers-amd64 -y

# Installs the driver
sudo apt install nvidia-driver firmware-misc-nonfree -y

# Installs the 32-bit graphics libraries
sudo apt install nvidia-driver-libs:i386 -y

# Extra configuration for Wayland
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service

echo "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia-options.conf >/dev/null
echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" | sudo tee -a /etc/modprobe.d/nvidia-options.conf >/dev/null

echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX nvidia-drm.modeset=1"' | sudo tee /etc/default/grub.d/nvidia-modeset.cfg >/dev/null
sudo update-grub
