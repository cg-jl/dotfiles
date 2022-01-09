#!/bin/sh

shutdown="  Shutdown"
restart="勒 Restart"
suspend="鈴  Sleep"
logout="  Logout"
hibernate="  Hibernate"




opts="$suspend\n$shutdown\n$restart\n$hibernate\n$logout"
chosen="$(echo -e "$opts" | rofi -theme ~/.config/polybar/rofi/launcher.rasi -p "" -dmenu -selected-row 0)"

case $chosen in
  $shutdown)
    systemctl poweroff
    ;;
  $restart)
    systemctl reboot
    ;;
  $suspend)
    # mpc -q pause
    amixer set Master mute
    systemctl suspend
    ;;

  $logout)
    i3-msg exit
    ;;

  $hibernate)
    amixer set Master mute
    systemctl hibernate
    ;;
esac
