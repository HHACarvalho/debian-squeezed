#!/bin/bash

install_list_apt=(
    brave-browser
    lutris
    mkvtoolnix-gui
    qbittorrent
    synaptic
    vlc
)

declare -A install_list_curl
install_list_curl["discord"]="https://discord.com/api/download?platform=linux"

declare -A install_list_custom
install_list_custom["brave"]="curl -fsS https://dl.brave.com/install.sh | sh"
install_list_custom["steam"]="sudo apt install steam-installer mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386 -y"

declare -A repo_list
repo_list["lutris"]="echo 'deb http://download.opensuse.org/repositories/home:/strycore/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/home:strycore.list; curl -fsSL https://download.opensuse.org/repositories/home:strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_strycore.gpg > /dev/null"
