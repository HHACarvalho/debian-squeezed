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
install_list_curl["steam"]="https://cdn.fastly.steamstatic.com/client/installer/steam.deb"

declare -A repo_list
repo_list["brave-browser"]="sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && echo 'deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main' | sudo tee /etc/apt/sources.list.d/brave-browser-release.list"
repo_list["lutris"]="echo 'deb [signed-by=/etc/apt/keyrings/lutris.gpg] https://download.opensuse.org/repositories/home:/strycore/Debian_12/ ./' | sudo tee /etc/apt/sources.list.d/lutris.list > /dev/null && wget -q -O- https://download.opensuse.org/repositories/home:/strycore/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/keyrings/lutris.gpg > /dev/null"
