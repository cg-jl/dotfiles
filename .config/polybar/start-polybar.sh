#!/bin/sh

CONFIG_PLACE=$HOME/.config/polybar/config.ini

bar() {
  polybar -q $1 --config=$CONFIG_PLACE & disown
}

killall polybar

# workspaces
bar workspaces
bar info
bar power
