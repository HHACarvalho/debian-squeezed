#!/bin/bash

# Changes:
# - Pins Brave, Konsole and Dolphin to the Taskbar

echo "
[Containments][2][Applets][5][Configuration][General]
launchers=applications:brave-browser.desktop,applications:org.kde.konsole.desktop,applications:org.kde.dolphin.desktop" >>~/.config/plasma-org.kde.plasma.desktop-appletsrc
