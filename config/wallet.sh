#!/bin/bash

# Changes:
# - Disables KDE wallet subsystem

echo "[Wallet]
Close When Idle=false
Close on Screensaver=false
Enabled=false
Idle Timeout=10
Launch Manager=false
Leave Manager Open=false
Leave Open=true
Prompt on Open=false
Use One Wallet=true

[org.freedesktop.secrets]
apiEnabled=true" >~/.config/kwalletrc
