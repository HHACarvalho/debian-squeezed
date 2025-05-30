#!/bin/bash

# Installs the linux kernel headers
sudo apt install linux-headers-$(uname -r) -y

if [[ "$1" == "nvidia" ]]; then

    # Uninstalls the latest version
    sudo apt purge --autoremove nvidia-driver* libxnvctrl* -y
    # Uninstalls the stable version
    sudo apt purge --autoremove *nvidia* -y

    if [[ "$2" == "latest" ]]; then

        # Adds the gpu driver repository
        curl -fsSo ~/Downloads/cuda-keyring.deb https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
        sudo apt install ~/Downloads/cuda-keyring.deb -y
        rm ~/Downloads/cuda-keyring.deb
        sudo apt update

        # Installs the gpu driver
        sudo apt install nvidia-driver nvidia-kernel-dkms -y
        #sudo apt install nvidia-driver nvidia-kernel-open-dkms -y

    else

        # Enables mode setting and preservation of all video memory allocations
        echo -e "options nvidia-drm modeset=1\noptions nvidia NVreg_PreserveVideoMemoryAllocations=1" | sudo tee /etc/modprobe.d/nvidia-options.conf >/dev/null

        # Installs the gpu driver
        sudo apt install nvidia-driver firmware-misc-nonfree nvidia-kernel-dkms -y
        #sudo apt install nvidia-driver firmware-misc-nonfree nvidia-open-kernel-dkms -y

    fi

elif [[ "$1" == "amd" ]]; then

    # TODO

else
    echo -e "Invalid version requested...\nAborting GPU driver installation..."
fi
