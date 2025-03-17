#!/bin/bash

# Changes:
# - Disables Software Center and Web Search Keywords on KRunner

echo "
[Plugins]
appstreamEnabled=false
webshortcutsEnabled=false" >>~/.config/krunnerrc
