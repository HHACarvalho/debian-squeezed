sudo apt purge akregator anthy* debian-reference* dragonplayer firefox-esr* gimp goldendict imagemagick* juk kaddressbook kdeconnect kmag kmail kmousetool kmouth knotes kontrast korganizer kwalletmanager libreoffice* mlterm* *mozc* pim-data-exporter pim-sieve-editor speech-dispatcher* vim-common vim-tiny wbrazilian wbulgarian wcatalan wdanish wdutch wfrench wngerman witalian wnorwegian wpolish wportuguese wspanish wswedish xiterm* xterm* -y

sudo apt autoremove -y # Uninstalls unused APT dependencies
sudo apt update -y     # Fetches the latest APT package lists
sudo apt upgrade -y    # Installs the latest version of installed APT packages

sudo apt-get install flatpak mkvtoolnix-gui qbittorrent synaptic vlc -y
sudo apt clean -y # Deletes all cached APT packages

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.brave.Browser com.discordapp.Discord com.valvesoftware.Steam com.vscodium.codium -y