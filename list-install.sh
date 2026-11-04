#!/bin/bash

install_list_apt=(
    aspell-en
    aspell-pt-pt
    brave-browser
    gaupol
    hunspell-en-gb
    hunspell-en-us
    hunspell-pt-pt
    iamerican
    ibritish
    iportuguese
    mkvtoolnix-gui
    ntpsec
    puddletag
    qbittorrent
    samba
    signal-desktop
    steam-installer
    synaptic
    vlc
    wamerican
    wbritish
    wportuguese
)

declare -A install_list_curl
install_list_curl["discord"]="https://discord.com/api/download?platform=linux"
install_list_curl["jellyfin"]="https://github.com/jellyfin/jellyfin-media-player/releases/download/v1.12.0/jellyfin-media-player_1.12.0-trixie.deb"

declare -A install_list_custom
install_list_custom["code"]="curl -fLo /tmp/squeezed/code.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' && echo 'code code/add-microsoft-repo boolean true' | sudo debconf-set-selections && sudo apt install /tmp/squeezed/code.deb -y"
install_list_custom["llama-cpp"]="curl -LsSf https://llama.app/install.sh | sh"
install_list_custom["mangohud"]="curl -fLo /tmp/squeezed/mangohud.tar.gz https://github.com/flightlessmango/MangoHud/releases/download/v0.8.4/MangoHud-0.8.4.r0.g992103e.tar.gz && tar -xzf /tmp/squeezed/mangohud.tar.gz -C /tmp/squeezed/ && cd /tmp/squeezed/MangoHud/ && ./mangohud-setup.sh install"

declare -A repo_list
repo_list["brave-browser"]="sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources"
repo_list["signal-desktop"]="curl https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg && cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null && curl -o signal-desktop.sources https://updates.signal.org/static/desktop/apt/signal-desktop.sources && cat signal-desktop.sources | sudo tee /etc/apt/sources.list.d/signal-desktop.sources > /dev/null && rm signal-desktop-keyring.gpg signal-desktop.sources"

# Watch out for updates for the following applications:
# - jellyfin
# - mangohud

# Useful applications:
# - conqueror
# - ghostwriter
