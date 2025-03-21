#!/bin/bash

# Disables KDE wallet subsystem
kwriteconfig5 --file ~/.config/kwalletrc --group Wallet --key Enabled "false"
