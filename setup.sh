#!/bin/bash

sudo apt purge akregator anthy-common aspell-am aspell-ar aspell-ar-large aspell-bg aspell-bn aspell-ca aspell-cs aspell-cy aspell-da aspell-de aspell-el aspell-eo aspell-es aspell-et aspell-eu aspell-fa aspell-fr aspell-ga aspell-gl-minimos aspell-gu aspell-he aspell-hi aspell-hr aspell-hu aspell-is aspell-it aspell-kk aspell-ku aspell-lt aspell-lv aspell-ml aspell-mr aspell-nl aspell-no aspell-pa aspell-pl aspell-pt-br aspell-ro aspell-ru aspell-sk aspell-sl aspell-sv aspell-ta aspell-te aspell-tl aspell-uk debian-reference-common dragonplayer firefox* gimp* goldendict ibrazilian ibritish ibulgarian icatalan idanish idutch ifrench-gut ihungarian iitalian ilithuanian ingerman inorwegian ipolish irussian ispanish iswiss imagemagick* juk kaddressbook kdeconnect kmag kmail kmousetool kmouth knotes kontrast korganizer kwalletmanager libreoffice* manpages-* mlterm-common mozc-* *-mozc myspell* *mythes* pim-data-exporter pim-sieve-editor speech-dispatcher vim-common wbrazilian wbulgarian wcatalan wdanish wdutch wfrench witalian wngerman wnorwegian wpolish wspanish wswedish xiterm+thai xterm -y

sudo apt autoremove -y # Uninstalls unused APT dependencies
sudo apt update -y     # Fetches the latest APT package lists
sudo apt upgrade -y    # Installs the latest version of installed APT packages

sudo apt install flatpak mkvtoolnix-gui qbittorrent synaptic vlc -y
sudo apt clean -y # Deletes all cached APT packages

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.brave.Browser com.discordapp.Discord com.valvesoftware.Steam com.vscodium.codium -y
