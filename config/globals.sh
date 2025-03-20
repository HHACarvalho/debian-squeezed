#!/bin/bash

# Applies the Breeze Dark theme
kwriteconfig5 --file ~/.config/kdeglobals --group KDE --key LookAndFeelPackage "org.kde.breezedark.desktop"

# Disables single-click
kwriteconfig5 --file ~/.config/kdeglobals --group KDE --key SingleClick "false"
