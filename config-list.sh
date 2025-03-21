#!/bin/bash

config_list=(
    accessibility
    boot
    caps-lock
    clock
    dolphin
    globals
    krunner
    system-tray
    taskbar
    wallet
)

config_mangohud() {

    # Configures MangoHud's display window
    mkdir -p ~/.config/MangoHud/
    echo -e "cpu_temp\nfps_limit=60\nframe_timing=0\ngpu_temp\nno_display\nram\nvram\nwidth=275" >~/.config/MangoHud/MangoHud.conf

    # Enables MangoHud by default in games
    echo -e "\nexport MANGOHUD=1" >>~/.profile
}
