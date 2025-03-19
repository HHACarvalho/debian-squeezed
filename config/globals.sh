#!/bin/bash

# Changes:
# - Applies the Breeze Dark theme
# - Disables single-click
# - Reveals hidden files by default

kwriteconfig5 --file ~/.config/kdeglobals --group KDE --key LookAndFeelPackage "org.kde.breezedark.desktop"
kwriteconfig5 --file ~/.config/kdeglobals --group KDE --key SingleClick "false"

kwriteconfig5 --file ~/.config/kdeglobals --group "KFileDialog Settings" --key "Show hidden files" "false"
