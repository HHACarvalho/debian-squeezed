#!/bin/bash

# Changes:
# - Enables automatic password-less login

sudo mkdir -p /etc/sddm.conf.d/

echo "[Autologin]
Relogin=false
Session=plasmawayland
User=$(whoami)

[General]
HaltCommand=
RebootCommand=

[Theme]
Current=

[Users]
MaximumUid=60000
MinimumUid=1000" | sudo tee /etc/sddm.conf.d/kde_settings.conf >/dev/null
