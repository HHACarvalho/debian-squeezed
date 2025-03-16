#!/bin/bash

# Changes:
# - Removes the confirmation dialog before Shutdown / Restart / Log out
# - Prevents saving the user session to allow for a complete restart of the OS

echo "
[General]
confirmLogout=false
loginMode=emptySession" >>~/.config/ksmserverrc
