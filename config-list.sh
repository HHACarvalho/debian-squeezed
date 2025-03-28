#!/bin/bash

config_list=(
    accessibility
    app-launcher
    auto-login
    boot
    caps-lock
    clock
    discord
    dolphin
    globals
    krunner
    mangohud
    sticky-keys
    system-tray
    taskbar
    wallet
)

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
    config_auto_login
    config_boot
    config_caps_lock
    config_clock
    config_discord
    config_dolphin
    config_globals
    config_krunner
    config_mangohud
    config_sticky_keys
    config_system_tray
    config_taskbar
    config_wallet
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
    echo "DELETE FROM 'ResourceLink'; INSERT INTO 'ResourceLink' VALUES (':global','org.kde.plasma.favorites.applications','applications:discord.desktop'), (':global','org.kde.plasma.favorites.applications','applications:org.kde.kate.desktop'), (':global','org.kde.plasma.favorites.applications','applications:org.bunkus.mkvtoolnix-gui.desktop'), (':global','org.kde.plasma.favorites.applications','applications:org.qbittorrent.qBittorrent.desktop'), (':global','org.kde.plasma.favorites.applications','applications:steam.desktop'), (':global','org.kde.plasma.favorites.applications','applications:systemsettings.desktop');" | sqlite3 ~/.local/share/kactivitymanagerd/resources/database
}

config_auto_login() {

    # Enables automatic password-less login
    sudo mkdir -p /etc/sddm.conf.d/
    echo -e "[Autologin]\nRelogin=false\nSession=plasma\nUser=$(whoami)\n\n[General]\nHaltCommand=\nRebootCommand=\n\n[Theme]\nCurrent=\n\n[Users]\nMaximumUid=60000\nMinimumUid=1000" | sudo tee /etc/sddm.conf.d/kde_settings.conf >/dev/null
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

    # Changes the date format to dd/MM/yyyy
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 21 --group Configuration --group Appearance --key customDateFormat "dd/MM/yyyy"
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 21 --group Configuration --group Appearance --key dateFormat "custom"

    # Changes the clock format to 24-Hour
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 21 --group Configuration --group Appearance --key use24hFormat "2"
}

config_discord() {

    # Launches Discord on startup
    mkdir -p ~/.config/autostart/
    echo -e "[Desktop Entry]\nExec=/usr/share/discord/Discord\nIcon=discord\nName=Discord\nType=Application" >~/.config/autostart/discord.desktop
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
    echo -e '<!DOCTYPE gui>\n<gui translationDomain="kxmlgui5" name="dolphin" version="38">\n <ToolBar alreadyVisited="1" name="mainToolBar" noMerge="1">\n  <text translationDomain="dolphin" context="@title:menu">Main Toolbar</text>\n  <Action name="go_back"/>\n  <Action name="go_forward"/>\n  <Separator name="separator_0"/>\n  <Action name="go_up"/>\n  <Separator name="separator_1"/>\n  <Action name="icons"/>\n  <Action name="details"/>\n  <Action name="url_navigators"/>\n  <Action name="hamburger_menu"/>\n </ToolBar>\n <ActionProperties scheme="Default">\n  <Action priority="0" name="go_back"/>\n  <Action priority="0" name="go_forward"/>\n  <Action priority="0" name="go_up"/>\n  <Action priority="0" name="icons"/>\n  <Action priority="0" name="details"/>\n </ActionProperties>\n</gui>' >~/.local/share/kxmlgui5/dolphin/dolphinui.rc
}

config_globals() {

    # Applies the Breeze Dark theme
    kwriteconfig6 --file ~/.config/kdeglobals --group KDE --key LookAndFeelPackage "org.kde.breezedark.desktop"
}

config_krunner() {

    # Disables Software Center and Web Search Keywords on KRunner
    kwriteconfig6 --file ~/.config/krunnerrc --group Plugins --key krunner_appstreamEnabled "false"
    kwriteconfig6 --file ~/.config/krunnerrc --group Plugins --key krunner_webshortcutsEnabled "false"
}

config_mangohud() {

    # Configures MangoHud's display window
    mkdir -p ~/.config/MangoHud/
    echo -e "cpu_temp\nfps_limit=60\nframe_timing=0\ngpu_temp\nno_display\nram\nvram\nwidth=275" >~/.config/MangoHud/MangoHud.conf

    # Enables MangoHud by default in games
    echo -e "\nexport MANGOHUD=1" >>~/.profile
}

config_sticky_keys() {

    # Enables the Hybrid asynchronous mode on IBus
    echo -e "\nexport IBUS_ENABLE_SYNC_MODE=2" >>~/.profile
}

config_system_tray() {

    # Disables and hides unnecessary icons on the System Tray
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 8 --group General --key extraItems "org.kde.plasma.devicenotifier,org.kde.plasma.keyboardlayout,org.kde.plasma.notifications,org.kde.plasma.networkmanagement,org.kde.plasma.clipboard,org.kde.plasma.volume,org.kde.plasma.manage-inputmethod,org.kde.plasma.cameraindicator"
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 8 --group General --key hiddenItems "chrome_status_icon_1,org.kde.plasma.clipboard,org.kde.plasma.manage-inputmethod,org.kde.plasma.devicenotifier,org.kde.plasma.keyboardlayout,Discover Notifier_org.kde.DiscoverNotifier,steam,Plasma_microphone,qBittorrent,Xwayland Video Bridge_pipewireToXProxy,plasmashell_microphone,xdg-desktop-portal-kde,org.kde.plasma.notifications"
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 8 --group General --key knownItems "org.kde.plasma.printmanager,org.kde.plasma.mediacontroller,org.kde.plasma.devicenotifier,org.kde.kscreen,org.kde.plasma.keyboardlayout,org.kde.plasma.notifications,org.kde.plasma.manage-inputmethod,org.kde.plasma.networkmanagement,org.kde.plasma.battery,org.kde.plasma.clipboard,org.kde.plasma.bluetooth,org.kde.plasma.volume,org.kde.plasma.cameraindicator,org.kde.plasma.brightness"
}

config_taskbar() {

    # Pins Brave, Dolphin and Konsole to the Taskbar
    kwriteconfig6 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 5 --group Configuration --group General --key launchers "applications:brave-browser.desktop,applications:org.kde.dolphin.desktop,applications:org.kde.konsole.desktop"
}

config_wallet() {

    # Disables KDE wallet subsystem
    kwriteconfig6 --file ~/.config/kwalletrc --group Wallet --key Enabled "false"
}
