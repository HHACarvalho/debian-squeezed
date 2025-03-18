#!/bin/bash

# Changes:
# - Adds the "contrib" and "non-free" components to the debian sources
# - Installs and configures the driver for NVIDIA GPUs

echo "deb https://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian bookworm main contrib non-free non-free-firmware

deb https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware
deb-src https://security.debian.org/debian-security bookworm-security main contrib non-free non-free-firmware

deb https://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src https://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list >/dev/null

sudo mkdir -p /etc/dracut.conf.d/
echo 'install_items+=" /etc/modprobe.d/nvidia-blacklists-nouveau.conf /etc/modprobe.d/nvidia.conf /etc/modprobe.d/nvidia-options.conf "' | sudo tee /etc/dracut.conf.d/nvidia-install.conf >/dev/null

sudo apt update
sudo apt install nvidia-driver firmware-misc-nonfree -y

sudo mkdir -p /etc/modprobe.d/
echo "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia-options.conf >/dev/null
echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" | sudo tee -a /etc/modprobe.d/nvidia-options.conf >/dev/null

echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX nvidia-drm.modeset=1"' | sudo tee /etc/default/grub.d/nvidia-modeset.cfg >/dev/null
sudo update-grub

sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
