#!/bin/bash

# Changes:
# - Disables the system bell sound and the screen reader

kwriteconfig5 --file ~/.config/kaccessrc --group Bell --key SystemBell "false"
kwriteconfig5 --file ~/.config/kaccessrc --group ScreenReader --key Enabled "false"
