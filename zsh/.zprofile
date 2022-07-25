# If running from tty1 start sway
[[ "$(tty)" == "/dev/tty1" ]] && exec sway
export SWAYSOCK=$(/usr/bin/ls /run/user/$EUID/sway-ipc.$EUID.*.sock | head -n1)
