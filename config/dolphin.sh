#!/bin/bash

# Changes:
# - Dolphin (File explorer):
#   * Enables path editing
#   * Disables saving opened tabs on close
#   * Hides the selection toggle and the status bar

kwriteconfig5 --file ~/.config/dolphinrc --group General --key EditableUrl "true"

kwriteconfig5 --file ~/.config/dolphinrc --group General --key RememberOpenedTabs "false"

kwriteconfig5 --file ~/.config/dolphinrc --group General --key ShowSelectionToggle "false"
kwriteconfig5 --file ~/.config/dolphinrc --group General --key ShowStatusBar "false"
