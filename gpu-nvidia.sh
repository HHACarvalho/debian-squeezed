#!/bin/bash

# Installs the linux kernel headers
sudo apt install linux-headers-$(uname -r) -y

# Installs the gpu driver
sudo apt install nvidia-kernel-dkms nvidia-driver firmware-misc-nonfree -y

# Installs the 32-bit graphics libraries
sudo apt install nvidia-driver-libs:i386 -y

# Enables kernel modesetting for the NVIDIA driver
echo 'GRUB_CMDLINE_LINUX="$GRUB_CMDLINE_LINUX nvidia-drm.modeset=1"' | sudo tee /etc/default/grub.d/nvidia-modeset.cfg >/dev/null
sudo update-grub

# Enables the power management services
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service

# Enables preservation of all video memory allocations
echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" | sudo tee -a /etc/modprobe.d/nvidia-options.conf >/dev/null
sudo update-initramfs -u
