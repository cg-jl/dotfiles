# If running from tty1 start sway

export TERM=xterm-256color
source ~/.zshrc
export XDG_CURRENT_DESKTOP=sway

[[ "$(tty)" == "/dev/tty1" ]] && exec dbus-run-session sway
export SWAYSOCK=$(/usr/bin/ls /run/user/$EUID/sway-ipc.$EUID.*.sock | head -n1)

