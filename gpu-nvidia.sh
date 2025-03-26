#!/bin/bash

# Installs the linux kernel headers
sudo apt install linux-headers-$(uname -r) -y

if [[ "$1" == "stable" ]]; then

    # Installs the gpu driver
    sudo apt install nvidia-kernel-dkms nvidia-driver firmware-misc-nonfree -y

    # Installs the 32-bit graphics libraries
    sudo apt install nvidia-driver-libs:i386 -y

    # Enables mode setting and preservation of all video memory allocations
    echo "options nvidia-drm modeset=1" | sudo tee -a /etc/modprobe.d/nvidia-options.conf >/dev/null
    echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" | sudo tee -a /etc/modprobe.d/nvidia-options.conf >/dev/null
    sudo update-initramfs -u

    # Enables the power management services
    sudo systemctl enable nvidia-suspend.service
    sudo systemctl enable nvidia-hibernate.service
    sudo systemctl enable nvidia-resume.service

elif [[ "$1" == "latest" ]]; then

    # Adds the gpu driver repository
    curl -fsSo /tmp/cuda-keyring.deb https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
    sudo apt install /tmp/cuda-keyring.deb -y
    rm /tmp/cuda-keyring.deb
    sudo apt update

    # Installs the gpu driver
    sudo apt install nvidia-driver nvidia-kernel-dkms -y

else
    echo -e "Invalid version requested...\nAborting NVIDIA GPU driver installation..."
fi
