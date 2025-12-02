#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-config -theme $HOME/.config/rofi/themes/powermenu-rounded-pink-dark.rasi"

# Options
lock=" Lock"
logout=" Logout"
suspend=" Sleep"
hibernate=" Hibernate"
reboot=" Restart"
shutdown=" Shutdown"

# Confirmation
confirm_exit() {
    echo -e "No\nYes" | rofi -dmenu \
        -no-config \
        -i \
        -no-fixed-num-lines \
        -p "Do You Want To $1?" \
        -theme "$HOME/.config/rofi/themes/powermenu-rounded-pink-dark.rasi"
}

# Variable passed to rofi
options="$lock\n$logout\n$suspend\n$hibernate\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"

case $chosen in
    $shutdown)
      ans=$(confirm_exit Shutdown &)
      if [[ "$ans" == "Yes" ]]; then
        systemctl poweroff
      fi
      ;;
    $reboot)
      ans=$(confirm_exit Reboot &)
      if [[ "$ans" == "Yes" ]]; then
        systemctl reboot
      fi
      ;;
    $lock)
      ans=$(confirm_exit Lock &)
      if [[ "$ans" == "Yes" ]]; then
        $HOME/.config/scripts/lock
      fi
      ;;
    $hibernate)
      ans=$(confirm_exit Hibernate &)
      if [[ "$ans" == "Yes" ]]; then
        systemctl hibernate
      fi
      ;;
    $suspend)
      ans=$(confirm_exit Suspend &)
      if [[ "$ans" == "Yes" ]]; then
        mpc -q pause
        amixer set Master mute
        systemctl suspend
      fi
      ;;
    $logout)
      ans=$(confirm_exit Logout &)
      if [[ "$ans" == "Yes" ]]; then
        sway exit
      fi
      ;;
esac
