#!/bin/bash

# Changes:
# - Pins Brave, Konsole and Dolphin to the Taskbar

kwriteconfig5 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 5 --group Configuration --group General --key launchers "applications:brave-browser.desktop,applications:org.kde.konsole.desktop,applications:org.kde.dolphin.desktop"
