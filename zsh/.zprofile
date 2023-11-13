# If running from tty1 start sway

if [[ "$TERM" = "linux" ]]; then
    true
else
    export TERM=xterm-256color
fi
export XDG_CURRENT_DESKTOP=sway


[[ "$(tty)" == "/dev/tty1" ]] && exec ~/.local/bin/sway
export SWAYSOCK=$(/usr/bin/ls /run/user/$EUID/sway-ipc.$EUID.*.sock | head -n1)
#systemctl --user import-environment XDG_CURRENT_DESKTOP WAYLAND_DISPLAY

path+="$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin"
