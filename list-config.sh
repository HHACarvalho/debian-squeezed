#!/bin/bash

sources_config() {

    # Adds the "contrib" and "non-free" components to the debian sources
    echo -e "Types: deb deb-src\nURIs: https://deb.debian.org/debian\nSuites: trixie trixie-updates\nComponents: main contrib non-free non-free-firmware\nEnabled: yes\nSigned-By: /usr/share/keyrings/debian-archive-keyring.gpg\n\nTypes: deb deb-src\nURIs: https://security.debian.org/debian-security\nSuites: trixie-security\nComponents: main contrib non-free non-free-firmware\nEnabled: yes\nSigned-By: /usr/share/keyrings/debian-archive-keyring.gpg" | sudo tee /etc/apt/sources.list.d/debian.sources >/dev/null

    # Deletes the old sources file
    sudo rm /etc/apt/sources.list

    # Adds the 32-bit architecture
    sudo dpkg --add-architecture i386
}

system_config() {

    config_accessibility
    config_app_launcher
    config_boot
    config_caps_lock
    config_clock
    config_discord
    config_dolphin
    config_globals
    config_keyboard
    config_krunner
    config_locale_purge
    config_mangohud
    config_night_light
    config_power
    config_spell_checker
    config_sticky_keys
    #config_swapfile
    config_system_tray
    config_taskbar
    config_vlc
}

config_accessibility() {

    # Disables unnecessary accessibility features
    kwriteconfig6 --file ~/.config/kaccessrc --group Bell --key SystemBell "false"
    kwriteconfig6 --file ~/.config/kaccessrc --group Keyboard --key AccessXBeep "false"
    kwriteconfig6 --file ~/.config/kwinrc --group Plugins --key shakecursorEnabled "false"

    # Sets the resolution scale to 100% on Wayland
    kscreen-doctor output.1.scale.1
}

config_app_launcher() {

    # Installs prerequisite
    sudo apt install sqlite3 -y

    # Adds Discord, Kate, MKVToolNix, qBittorrent, Steam and System Settings to the favorites list in the Application Launcher
    echo "DELETE FROM 'ResourceLink'; INSERT INTO 'ResourceLink' VALUES (':global','org.kde.plasma.favorites.applications','applications:discord.desktop'), (':global','org.kde.plasma.favorites.applications','applications:io.otsaloma.gaupol.desktop'), (':global','org.kde.plasma.favorites.applications','applications:heroic.desktop'), (':global','org.kde.plasma.favorites.applications','applications:org.kde.kate.desktop'), (':global','org.kde.plasma.favorites.applications','applications:org.bunkus.mkvtoolnix-gui.desktop'), (':global','org.kde.plasma.favorites.applications','applications:org.qbittorrent.qBittorrent.desktop'), (':global','org.kde.plasma.favorites.applications','applications:steam.desktop'), (':global','org.kde.plasma.favorites.applications','applications:systemsettings.desktop');" | sqlite3 ~/.local/share/kactivitymanagerd/resources/database
}

config_boot() {

    # Removes the confirmation dialog before logging out
    kwriteconfig6 --file ~/.config/ksmserverrc --group General --key confirmLogout "false"

    # Wipes user session on logout
    kwriteconfig6 --file ~/.config/ksmserverrc --group General --key loginMode "emptySession"
}

config_caps_lock() {

    # Fixes the Caps Lock delay
    mkdir -p ~/.config/xkb/symbols/
    echo -e 'hidden partial modifier_keys\nxkb_symbols "caps_lock_fix" {\n    key <CAPS> {\n        type="ALPHABETIC",\n        repeat=No,\n        symbols[Group1] = [ Caps_Lock, Caps_Lock ],\n        actions[Group1] = [ LockMods(modifiers=Lock), LockMods(modifiers=Shift+Lock,affect=unlock) ]\n    };\n};' >~/.config/xkb/symbols/custom

    mkdir -p ~/.config/xkb/rules/
    echo -e '! option = symbols\ncustom:caps_lock_fix = +custom(caps_lock_fix)\n! include %S/evdev' >~/.config/xkb/rules/evdev

    kwriteconfig6 --file ~/.config/kxkbrc --group Layout --key Options custom:caps_lock_fix
    kwriteconfig6 --file ~/.config/kxkbrc --group Layout --key ResetOldOptions true
}

config_clock() {

    # Enables NTP
    sudo apt install ntp -y
    sudo timedatectl set-ntp true

    # Changes the date format to dd/MM/yyyy
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 21 --group Configuration --group Appearance --key customDateFormat "dd/MM/yyyy"
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 21 --group Configuration --group Appearance --key dateFormat "custom"

    # Changes the clock format to 24-Hour
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 21 --group Configuration --group Appearance --key use24hFormat "2"
}

config_discord() {

    # Launches Discord on startup
    mkdir -p ~/.config/autostart/
    echo -e "[Desktop Entry]\nExec=bash -c 'sleep 5 && /usr/share/discord/Discord'\nIcon=discord\nName=Discord\nType=Application" >~/.config/autostart/discord.desktop
}

config_dolphin() {

    # Enables path editing
    kwriteconfig6 --file ~/.config/dolphinrc --group General --key EditableUrl "true"

    # Forgets opened tabs on close
    kwriteconfig6 --file ~/.config/dolphinrc --group General --key RememberOpenedTabs "false"

    # Hides the selection toggle and the status bar
    kwriteconfig6 --file ~/.config/dolphinrc --group General --key ShowSelectionToggle "false"
    kwriteconfig6 --file ~/.config/dolphinrc --group General --key ShowStatusBar "false"

    # Customizes the toolbar's appearance
    mkdir -p ~/.local/share/kxmlgui5/dolphin/
    echo -e '<!DOCTYPE gui>\n<gui translationDomain="kxmlgui5" name="dolphin" version="38">\n <ToolBar alreadyVisited="1" name="mainToolBar" noMerge="1">\n  <text translationDomain="dolphin" context="@title:menu">Main Toolbar</text>\n  <Action name="go_back"/>\n  <Action name="go_forward"/>\n  <Separator name="separator_0"/>\n  <Action name="go_up"/>\n  <Separator name="separator_1"/>\n  <Action name="icons"/>\n  <Action name="details"/>\n  <Action name="url_navigators"/>\n  <Action name="hamburger_menu"/>\n </ToolBar>\n <ActionProperties scheme="Default">\n  <Action priority="0" name="go_back"/>\n  <Action priority="0" name="go_forward"/>\n  <Action priority="0" name="go_up"/>\n  <Action priority="0" name="icons"/>\n  <Action priority="0" name="details"/>\n </ActionProperties>\n</gui>' >~/.local/share/kxmlgui5/dolphin/dolphinui.rc
}

config_globals() {

    # Applies the Breeze Dark theme
    kwriteconfig6 --file ~/.config/kdeglobals --group KDE --key LookAndFeelPackage "org.kde.breezedark.desktop"
}

config_keyboard() {

    # Adds both portuguese and english keyboard layouts
    kwriteconfig6 --file ~/.config/kxkbrc --group Layout --key LayoutList "pt,us"
    kwriteconfig6 --file ~/.config/kxkbrc --group Layout --key Use "true"

    # Defines Shift+F9 as the keyboard shortcut to alternate between keyboard layouts
    kwriteconfig6 --file ~/.config/kglobalshortcutsrc --group "KDE Keyboard Layout Switcher" --key "Switch to Next Keyboard Layout" "Shift+F9,Meta+Alt+K,Switch to Next Keyboard Layout"
}

config_krunner() {

    # Disables Software Center and Web Search Keywords on KRunner
    kwriteconfig6 --file ~/.config/krunnerrc --group Plugins --key krunner_appstreamEnabled "false"
    kwriteconfig6 --file ~/.config/krunnerrc --group Plugins --key krunner_webshortcutsEnabled "false"
}

config_locale_purge() {

    # Configures localepurge
    echo -e "MANDELETE\nDONTBOTHERNEWLOCALE\nSHOWFREEDSPACE\n\nen\nen_US.UTF-8" | sudo tee /etc/locale.nopurge >/dev/null

    # Installs localepurge
    sudo DEBIAN_FRONTEND=noninteractive apt install localepurge -y

    # Runs localepurge
    sudo localepurge
}

config_mangohud() {

    # Configures MangoHud's display window
    mkdir -p ~/.config/MangoHud/
    echo -e "cpu_temp\nfps_limit=60\nframe_timing=0\n#gpu_list=0,1\ngpu_temp\nno_display\nram\nvram\nwidth=275" >~/.config/MangoHud/MangoHud.conf

    # Enables MangoHud by default in games
    echo -e "\nexport MANGOHUD=1" >>~/.profile
}

config_night_light() {

    # Activates the night light
    kwriteconfig6 --file ~/.config/kwinrc --group NightColor --key Active "true"
    kwriteconfig6 --file ~/.config/kwinrc --group NightColor --key Mode "Constant"
    kwriteconfig6 --file ~/.config/kwinrc --group NightColor --key NightTemperature "6000"
}

config_power() {

    # Prevents automatic screen lock
    kwriteconfig6 --file ~/.config/kscreenlockerrc --group Daemon --key Autolock "false"
    kwriteconfig6 --file ~/.config/kscreenlockerrc --group Daemon --key LockOnResume "false"
    kwriteconfig6 --file ~/.config/kscreenlockerrc --group Daemon --key Timeout "0"

    # Prevents sleep when inactive
    kwriteconfig6 --file ~/.config/powerdevilrc --group AC --group SuspendAndShutdown --key AutoSuspendAction "0"

    # Changes the power button's behaviour to shutdown
    kwriteconfig6 --file ~/.config/powerdevilrc --group AC --group SuspendAndShutdown --key PowerButtonAction "8"
}

config_spell_checker() {

    # Install the portuguese dictionary
    sudo apt install hunspell-pt-pt

    # Enables the spell checker by default and adds both english and portuguese as preferred languages
    mkdir -p ~/.config/KDE/
    kwriteconfig6 --file ~/.config/KDE/Sonnet.conf --group General --key checkerEnabledByDefault "true"
    kwriteconfig6 --file ~/.config/KDE/Sonnet.conf --group General --key preferredLanguages "en_US, pt_PT"
}

config_sticky_keys() {

    # Enables the Hybrid asynchronous mode on IBus
    echo -e "\nexport IBUS_ENABLE_SYNC_MODE=2" >>~/.profile
}

config_swapfile() {

    # Create the swap file
    sudo fallocate -l 16G /swapfile

    # Sets the permissions to root only
    sudo chmod 600 /swapfile

    # Format the file as swap (UUID)
    sudo mkswap /swapfile

    # Activate the swap file (session)
    sudo swapon /swapfile

    # Activate the swap file (permanent)
    echo -e "\n/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab >/dev/null
}

config_system_tray() {

    # Disables and hides unnecessary icons on the System Tray
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 8 --group General --key extraItems "org.kde.plasma.devicenotifier,org.kde.plasma.keyboardlayout,org.kde.plasma.notifications,org.kde.plasma.networkmanagement,org.kde.plasma.clipboard,org.kde.plasma.volume,org.kde.plasma.manage-inputmethod,org.kde.plasma.cameraindicator,org.kde.plasma.keyboardindicator,vlc"
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 8 --group General --key hiddenItems "chrome_status_icon_1,org.kde.plasma.clipboard,org.kde.plasma.manage-inputmethod,org.kde.plasma.devicenotifier,org.kde.plasma.keyboardlayout,Discover Notifier_org.kde.DiscoverNotifier,steam,Plasma_microphone,qBittorrent,Xwayland Video Bridge_pipewireToXProxy,plasmashell_microphone,xdg-desktop-portal-kde,org.kde.plasma.notifications,vlc"
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 8 --group General --key knownItems "org.kde.plasma.printmanager,org.kde.plasma.mediacontroller,org.kde.plasma.devicenotifier,org.kde.kscreen,org.kde.plasma.keyboardlayout,org.kde.plasma.notifications,org.kde.plasma.manage-inputmethod,org.kde.plasma.networkmanagement,org.kde.plasma.battery,org.kde.plasma.clipboard,org.kde.plasma.bluetooth,org.kde.plasma.volume,org.kde.plasma.cameraindicator,org.kde.plasma.brightness,org.kde.plasma.keyboardindicator"
}

config_taskbar() {

    # Pins Brave, Dolphin and Konsole to the Taskbar
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 5 --group Configuration --group General --key launchers "applications:brave-browser.desktop,applications:org.kde.dolphin.desktop,applications:org.kde.konsole.desktop"
}

config_vlc() {

    # Disables hardware acceleration by default and sets the short jump size to 4 seconds
    mkdir -p ~/.config/vlc/
    echo -e "avcodec-hw=none\nshort-jump-size=4" >~/.config/vlc/vlcrc

    # Sets VLC as the default application for MKV files
    kwriteconfig6 --file ~/.config/mimeapps.list --group "Added Associations" --key "video/x-matroska" "vlc.desktop;org.bunkus.mkvtoolnix-gui.desktop;"
}
