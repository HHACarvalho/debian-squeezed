#!/bin/bash

# Changes:
# - Removes the confirmation dialog before Shutdown / Restart / Log out
# - Prevents saving the user session to allow for a complete restart of the OS

kwriteconfig5 --file ~/.config/ksmserverrc --group General --key confirmLogout "false"
kwriteconfig5 --file ~/.config/ksmserverrc --group General --key loginMode "emptySession"
