#!/bin/bash

# Adds the "contrib" and "non-free" components to the debian sources
echo "deb https://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian bookworm main contrib non-free non-free-firmware

deb https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

deb https://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list >/dev/null

# Installs the driver
sudo apt update
sudo apt install nvidia-driver firmware-misc-nonfree -y

echo "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia-options.conf >/dev/null
echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" | sudo tee -a /etc/modprobe.d/nvidia-options.conf >/dev/null

echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX nvidia-drm.modeset=1"' | sudo tee /etc/default/grub.d/nvidia-modeset.cfg >/dev/null
sudo update-grub

sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
