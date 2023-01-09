# If running from tty1 start sway

export TERM=xterm-256color
source ~/.zshrc
export XDG_CURRENT_DESKTOP=sway
export XDG_RUNTIME_DIR=/run/user/1000
export XCURSOR_PATH="${XCURSOR_PATH}:$HOME/.local/share/icons"

if ! test -d "$XDG_RUNTIME_DIR"; then
	mkdir "$XDG_RUNTIME_DIR"
	chmod 0700 "$XDG_RUNTIME_DIR"
fi


gentoo-pipewire-launcher &

[[ "$(tty)" == "/dev/tty1" ]] && exec dbus-run-session sway
export SWAYSOCK=$(/usr/bin/ls /run/user/$EUID/sway-ipc.$EUID.*.sock | head -n1)

export QSYS_ROOTDIR="/home/gsus/installs/intelFPGA_lite/22.1std/quartus/sopc_builder/bin"
#systemctl --user import-environment XDG_CURRENT_DESKTOP WAYLAND_DISPLAY
