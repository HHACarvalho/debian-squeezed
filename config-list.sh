#!/bin/bash

config_list=(
    accessibility
    boot
    caps-lock
    clock
    dolphin
    globals
    krunner
    mangohud
    system-tray
    taskbar
    wallet
)

system_config() {
    config_accessibility
    config_boot
    config_caps_lock
    config_clock
    config_dolphin
    config_globals
    config_krunner
    config_mangohud
    config_system_tray
    config_taskbar
    config_wallet
}

config_accessibility() {

    # Disables the system bell and screen reader
    kwriteconfig5 --file ~/.config/kaccessrc --group Bell --key SystemBell "false"
    kwriteconfig5 --file ~/.config/kaccessrc --group ScreenReader --key Enabled "false"
}

config_boot() {

    # Removes the confirmation dialog before logging out
    kwriteconfig5 --file ~/.config/ksmserverrc --group General --key confirmLogout "false"

    # Wipes user session on logout
    kwriteconfig5 --file ~/.config/ksmserverrc --group General --key loginMode "emptySession"
}

config_caps_lock() {

    # Fixes the Caps Lock delay
    mkdir -p ~/.config/xkb/symbols/
    echo -e 'hidden partial modifier_keys\nxkb_symbols "caps_lock_fix" {\n    key <CAPS> {\n        type="ALPHABETIC",\n        repeat=No,\n        symbols[Group1] = [ Caps_Lock, Caps_Lock ],\n        actions[Group1] = [ LockMods(modifiers=Lock), LockMods(modifiers=Shift+Lock,affect=unlock) ]\n    };\n};' >~/.config/xkb/symbols/custom

    mkdir -p ~/.config/xkb/rules/
    echo -e '! option = symbols\ncustom:caps_lock_fix = +custom(caps_lock_fix)\n! include %S/evdev' >~/.config/xkb/rules/evdev

    kwriteconfig5 --file ~/.config/kxkbrc --group Layout --key Options custom:caps_lock_fix
    kwriteconfig5 --file ~/.config/kxkbrc --group Layout --key ResetOldOptions true
}

config_clock() {

    # Changes the date format to dd/MM/yyyy
    kwriteconfig5 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 20 --group Configuration --group Appearance --key customDateFormat "dd/MM/yyyy"
    kwriteconfig5 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 20 --group Configuration --group Appearance --key dateFormat "custom"

    # Changes the clock format to 24-Hour
    kwriteconfig5 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 20 --group Configuration --group Appearance --key use24hFormat "2"
}

config_dolphin() {

    # Enables path editing
    kwriteconfig5 --file ~/.config/dolphinrc --group General --key EditableUrl "true"

    # Forgets opened tabs on close
    kwriteconfig5 --file ~/.config/dolphinrc --group General --key RememberOpenedTabs "false"

    # Hides the selection toggle and the status bar
    kwriteconfig5 --file ~/.config/dolphinrc --group General --key ShowSelectionToggle "false"
    kwriteconfig5 --file ~/.config/dolphinrc --group General --key ShowStatusBar "false"
}

config_globals() {

    # Applies the Breeze Dark theme
    kwriteconfig5 --file ~/.config/kdeglobals --group KDE --key LookAndFeelPackage "org.kde.breezedark.desktop"

    # Disables single-click
    kwriteconfig5 --file ~/.config/kdeglobals --group KDE --key SingleClick "false"
}

config_krunner() {

    # Disables Software Center and Web Search Keywords on KRunner
    kwriteconfig5 --file ~/.config/krunnerrc --group Plugins --key appstreamEnabled "false"
    kwriteconfig5 --file ~/.config/krunnerrc --group Plugins --key webshortcutsEnabled "false"
}

config_mangohud() {

    # Configures MangoHud's display window
    mkdir -p ~/.config/MangoHud/
    echo -e "cpu_temp\nfps_limit=60\nframe_timing=0\ngpu_temp\nno_display\nram\nvram\nwidth=275" >~/.config/MangoHud/MangoHud.conf

    # Enables MangoHud by default in games
    echo -e "\nexport MANGOHUD=1" >>~/.profile
}

config_system_tray() {

    # Disables and hides unnecessary icons on the System Tray
    kwriteconfig5 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 8 --group General --key extraItems "org.kde.plasma.devicenotifier,org.kde.plasma.keyboardlayout,org.kde.plasma.notifications,org.kde.plasma.networkmanagement,org.kde.plasma.clipboard,org.kde.plasma.volume,org.kde.plasma.manage-inputmethod,qBittorrent"
    kwriteconfig5 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 8 --group General --key hiddenItems "chrome_status_icon_1,org.kde.plasma.clipboard,org.kde.plasma.manage-inputmethod,org.kde.plasma.devicenotifier,org.kde.plasma.keyboardlayout,Discover Notifier_org.kde.DiscoverNotifier,steam,Plasma_microphone,qBittorrent"
    kwriteconfig5 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 8 --group General --key knownItems "org.kde.plasma.printmanager,org.kde.plasma.mediacontroller,org.kde.plasma.devicenotifier,org.kde.kscreen,org.kde.plasma.keyboardlayout,org.kde.plasma.notifications,org.kde.plasma.manage-inputmethod,org.kde.plasma.networkmanagement,org.kde.plasma.battery,org.kde.plasma.clipboard,org.kde.plasma.bluetooth,org.kde.plasma.volume"
}

config_taskbar() {

    # Pins Brave, Konsole and Dolphin to the Taskbar
    kwriteconfig5 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 5 --group Configuration --group General --key launchers "applications:brave-browser.desktop,applications:org.kde.konsole.desktop,applications:org.kde.dolphin.desktop"
}

config_wallet() {

    # Disables KDE wallet subsystem
    kwriteconfig5 --file ~/.config/kwalletrc --group Wallet --key Enabled "false"
}
