#!/bin/bash

# Changes:
# - Disables and hides unnecessary icons on the System Tray

echo "
[Containments][8][General]
extraItems=org.kde.plasma.devicenotifier,org.kde.plasma.keyboardlayout,org.kde.plasma.notifications,org.kde.plasma.networkmanagement,org.kde.plasma.clipboard,org.kde.plasma.volume,org.kde.plasma.manage-inputmethod
hiddenItems=chrome_status_icon_1,org.kde.plasma.clipboard,org.kde.plasma.manage-inputmethod,org.kde.plasma.devicenotifier,org.kde.plasma.keyboardlayout,Discover Notifier_org.kde.DiscoverNotifier,steam,Plasma_microphone
knownItems=org.kde.plasma.printmanager,org.kde.plasma.mediacontroller,org.kde.plasma.devicenotifier,org.kde.kscreen,org.kde.plasma.keyboardlayout,org.kde.plasma.notifications,org.kde.plasma.manage-inputmethod,org.kde.plasma.networkmanagement,org.kde.plasma.battery,org.kde.plasma.clipboard,org.kde.plasma.bluetooth,org.kde.plasma.volume" >>~/.config/plasma-org.kde.plasma.desktop-appletsrc
