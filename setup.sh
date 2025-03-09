#!/bin/bash

purge_list=(
	*aspell*
	*hunspell*
	*mythes*
	akregator
	busybox
	debian-reference-common
	dragonplayer
	fakeroot
	firefox*
	gimp*
	goldendict
	hspell
	hunspell*
	ibrazilian
	ibritish
	ibulgarian
	icatalan
	idanish
	idutch
	ifrench-gut
	ihungarian
	iitalian
	ilithuanian
	imagemagick*
	ingerman
	inorwegian
	ipolish
	irussian
	ispanish
	iswiss
	juk
	kaddressbook
	kdeconnect
	khelpcenter
	kmag
	kmail
	kmousetool
	kmouth
	knotes
	konqueror
	kontrast
	korganizer
	kwalletmanager
	kwrite
	libreoffice*
	manpages*
	mariadb-common
	mlterm-common
	mozc-*
	myspell*
	pim-data-exporter
	pim-sieve-editor
	plasma-vault
	plasma-widgets-addons
	speech-dispatcher
	sweeper
	task-albanian*
	task-amharic*
	task-arabic*
	task-asturian*
	task-basque*
	task-belarusian*
	task-bengali*
	task-bosnian*
	task-brazilian*
	task-british*
	task-bulgarian*
	task-catalan*
	task-chinese-s*
	task-chinese-t*
	task-croatian*
	task-cyrillic*
	task-czech*
	task-danish*
	task-dutch*
	task-dzongkha*
	task-esperanto*
	task-estonian*
	task-finnish*
	task-french*
	task-galician*
	task-georgian*
	task-german*
	task-greek*
	task-gujarati*
	task-hebrew*
	task-hindi*
	task-hungarian*
	task-icelandic*
	task-indonesian*
	task-irish*
	task-italian*
	task-japanese*
	task-kannada*
	task-kazakh*
	task-khmer*
	task-korean*
	task-kurdish*
	task-latvian*
	task-lithuanian*
	task-macedonian*
	task-malayalam*
	task-marathi*
	task-nepali*
	task-northern-sami*
	task-norwegian*
	task-persian*
	task-polish*
	task-portuguese*
	task-punjabi*
	task-romanian*
	task-russian*
	task-serbian*
	task-sinhala*
	task-slovak*
	task-slovenian*
	task-south-african*
	task-spanish*
	task-swedish*
	task-tagalog*
	task-tamil*
	task-telugu*
	task-thai*
	task-turkish*
	task-ukrainian*
	task-uyghur*
	task-vietnamese*
	task-welsh*
	task-xhosa*
	vim-common
	wbrazilian
	wbulgarian
	wcatalan
	wdanish
	wdutch
	wfrench
	witalian
	wngerman
	wnorwegian
	wpolish
	wspanish
	wswedish
	xiterm+thai
	xterm
)

install_list=(
	flatpak
	mkvtoolnix-gui
	qbittorrent
	synaptic
	vlc
)

sudo apt purge "${purge_list[@]}" -y

sudo apt autoremove -y # Uninstalls unused APT dependencies
sudo apt update -y     # Fetches the latest APT package lists
sudo apt upgrade -y    # Installs the latest version of installed APT packages

sudo apt install "${install_list[@]}" -y
sudo apt clean -y # Deletes all cached APT packages

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.brave.Browser com.discordapp.Discord com.valvesoftware.Steam com.vscodium.codium -y
