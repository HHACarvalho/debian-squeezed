#!/bin/bash

# Installs the linux kernel headers
sudo apt install linux-headers-$(uname -r) -y

if [[ "$1" == "nvidia" ]]; then

    if dpkg -l | grep -q nvidia-driver; then

        # Uninstalls the current driver
        sudo apt purge --autoremove nvidia-driver\* libxnvctrl\* -y
    else

        # Adds the gpu driver repository
        curl -fsSo /tmp/squeezed/cuda-keyring.deb https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb
        sudo apt install /tmp/squeezed/cuda-keyring.deb -y
        sudo apt update
    fi

    # Installs the gpu driver
    sudo apt install nvidia-driver nvidia-kernel-dkms -y

elif [[ "$1" == "amd" ]]; then

    if dpkg -l | grep -q amdgpu-dkms; then

        # Uninstalls the current driver
        sudo apt purge --autoremove amdgpu-dkms -y
    else

        # Adds the gpu driver repository
        echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/amdgpu/latest/ubuntu jammy main" | sudo tee /etc/apt/sources.list.d/amdgpu.list
        sudo apt update
    fi

    # Installs the gpu driver
    sudo apt install amdgpu-dkms

else
    echo -e "Invalid version requested...\nAborting GPU driver installation..."
fi
