#!/bin/bash

# Enables path editing
kwriteconfig5 --file ~/.config/dolphinrc --group General --key EditableUrl "true"

# Forgets opened tabs on close
kwriteconfig5 --file ~/.config/dolphinrc --group General --key RememberOpenedTabs "false"

# Hides the selection toggle and the status bar
kwriteconfig5 --file ~/.config/dolphinrc --group General --key ShowSelectionToggle "false"
kwriteconfig5 --file ~/.config/dolphinrc --group General --key ShowStatusBar "false"
