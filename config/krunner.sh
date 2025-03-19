#!/bin/bash

# Changes:
# - Disables Software Center and Web Search Keywords on KRunner

kwriteconfig5 --file ~/.config/krunnerrc --group Plugins --key appstreamEnabled "false"
kwriteconfig5 --file ~/.config/krunnerrc --group Plugins --key webshortcutsEnabled "false"
