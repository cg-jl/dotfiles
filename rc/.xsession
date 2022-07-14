#!/bin/sh
picom --experimental-backends -f &

xset +fp ~/.local/share/fonts
sh ~/.fehbg

# dvorak:
# setxkbmap -layout us,es -variant dvorak,dvorak -option 'grp:alt_space_toggle' &
setxkbmap -layout us,es -variant dvorak,dvorak -option 'grp:alt_space_toggle' &
xset -b &
xset r rate 300 50 &
inputplug -d -c ~/.local/scripts/on-new-kbd &
sh ~/.config/polybar/start-polybar.sh &
disown
