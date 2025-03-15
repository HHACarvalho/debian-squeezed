#!/bin/bash

# Changes:
# - Fixes the Caps Lock delay

mkdir -p ~/.config/xkb/symbols/
echo 'hidden partial modifier_keys
xkb_symbols "caps_lock_fix" {
    key <CAPS> {
        type="ALPHABETIC",
        repeat=No,
        symbols[Group1] = [ Caps_Lock, Caps_Lock ],
        actions[Group1] = [ LockMods(modifiers=Lock), LockMods(modifiers=Shift+Lock,affect=unlock) ]
    };
};' >~/.config/xkb/symbols/custom

mkdir -p ~/.config/xkb/rules/
echo '! option = symbols
custom:caps_lock_fix = +custom(caps_lock_fix)
! include %S/evdev' >~/.config/xkb/rules/evdev

echo '[$Version]
update_info=kxkb.upd:remove-empty-lists,kxkb.upd:add-back-resetoptions,kxkb_variants.upd:split-variants

[Layout]
Options=custom:caps_lock_fix
ResetOldOptions=true' >~/.config/kxkbrc
