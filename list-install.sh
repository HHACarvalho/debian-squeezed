#!/bin/bash

install_list_apt=(
    brave-browser
    mkvtoolnix-gui
    qbittorrent
    synaptic
    vlc
)

declare -A install_list_curl
install_list_curl["discord"]="https://discord.com/api/download?platform=linux"

declare -A install_list_custom
install_list_custom["mangohud"]="curl -fLo /tmp/squeezed/MangoHud.tar.gz https://github.com/flightlessmango/MangoHud/releases/download/v0.8.1/MangoHud-0.8.1.r0.gfea4292.tar.gz && tar -xzf /tmp/squeezed/MangoHud.tar.gz -C /tmp/squeezed/ && cd /tmp/squeezed/MangoHud/ && ./mangohud-setup.sh install"
install_list_custom["steam"]="sudo apt install steam-installer mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386 -y"

declare -A repo_list
repo_list["brave"]="sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main' | sudo tee /etc/apt/sources.list.d/brave-browser-release.list >/dev/null"
