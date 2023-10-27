# If running from tty1 start sway

if [[ "$TERM" = "linux" ]]; then
    true
else
    export TERM=xterm-256color
fi
source ~/.zshrc
#export XDG_CURRENT_DESKTOP=sway


#[[ "$(tty)" == "/dev/tty1" ]] && exec ~/.local/bin/sway
#export SWAYSOCK=$(/usr/bin/ls /run/user/$EUID/sway-ipc.$EUID.*.sock | head -n1)

export QSYS_ROOTDIR="/home/gsus/installs/intelFPGA_lite/22.1std/quartus/sopc_builder/bin"
#systemctl --user import-environment XDG_CURRENT_DESKTOP WAYLAND_DISPLAY
