#!/bin/bash

# Changes:
# - Changes the date format to dd/MM/yyyy
# - Changes the clock format to 24-Hour

echo "
[Containments][2][Applets][20][Configuration][Appearance]
customDateFormat=dd/MM/yyyy
dateFormat=custom
use24hFormat=2" >>~/.config/plasma-org.kde.plasma.desktop-appletsrc
