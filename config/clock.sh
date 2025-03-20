#!/bin/bash

# Changes the date format to dd/MM/yyyy
kwriteconfig5 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 20 --group Configuration --group Appearance --key customDateFormat "dd/MM/yyyy"
kwriteconfig5 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 20 --group Configuration --group Appearance --key dateFormat "custom"

# Changes the clock format to 24-Hour
kwriteconfig5 --file ~/.config/plasma-org.kde.plasma.desktop-appletsrc --group Containments --group 2 --group Applets --group 20 --group Configuration --group Appearance --key use24hFormat "2"
