#!/bin/bash

# Changes:
# - Dolphin (File explorer):
#   * Enables path editing
#   * No longer saves opened tabs on close
#   * Hides the selection toggle and the status bar

echo "
[General]
EditableUrl=true
RememberOpenedTabs=false
ShowSelectionToggle=false
ShowStatusBar=false" >>~/.config/dolphinrc
