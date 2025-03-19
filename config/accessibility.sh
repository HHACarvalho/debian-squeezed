#!/bin/bash

# Changes:
# - Pins Brave, Konsole and Dolphin to the Taskbar

kwriteconfig5 --file ~/.config/kaccessrc --group Bell --key SystemBell "false"
kwriteconfig5 --file ~/.config/kaccessrc --group ScreenReader --key Enabled "false"
