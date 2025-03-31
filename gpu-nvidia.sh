#!/bin/bash

# Installs the linux kernel headers
sudo apt install linux-headers-$(uname -r) -y

if [[ "$1" == "nvidia" ]]; then

    # Adds the gpu driver repository
    curl -fsSo /tmp/squeezed/cuda-keyring.deb https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
    sudo apt install /tmp/squeezed/cuda-keyring.deb -y
    sudo apt update

    # Installs the gpu driver
    sudo apt install nvidia-driver nvidia-kernel-dkms -y

elif [[ "$1" == "latest" ]]; then

    # Adds the gpu driver repository
    curl -fsSo /tmp/squeezed/cuda-keyring.deb https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
    sudo apt install /tmp/squeezed/cuda-keyring.deb -y
    sudo apt update

    # Installs the gpu driver
    sudo apt install nvidia-driver nvidia-kernel-dkms -y

else
    echo -e "Invalid version requested...\nAborting NVIDIA GPU driver installation..."
fi
