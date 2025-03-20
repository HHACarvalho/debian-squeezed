#!/bin/bash

# Removes the confirmation dialog before logging out
kwriteconfig5 --file ~/.config/ksmserverrc --group General --key confirmLogout "false"

# Wipes user session on logout
kwriteconfig5 --file ~/.config/ksmserverrc --group General --key loginMode "emptySession"
