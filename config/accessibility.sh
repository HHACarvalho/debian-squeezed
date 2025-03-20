#!/bin/bash

# Disables the system bell and screen reader
kwriteconfig5 --file ~/.config/kaccessrc --group Bell --key SystemBell "false"
kwriteconfig5 --file ~/.config/kaccessrc --group ScreenReader --key Enabled "false"
