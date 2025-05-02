#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-config -theme $HOME/.config/rofi/themes/powermenu-rounded-pink-dark.rasi"

# Options
shutdown=" Shutdown"
reboot=" Restart"
lock=" Lock"
suspend=" Sleep"
logout=" Logout"
hibernate=" Hibernate"

# Confirmation
confirm_exit() {
	rofi -dmenu\
        -no-config\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme $dir/confirm.rasi
}

# Message
msg() {
	rofi -no-config -theme "$HOME/.config/rofi/themes/powermenu-rounded-pink-dark.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$suspend\n$hibernate\n$logout\n$reboot\n$shutdown\n$lock"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
		ans=$(confirm_exit &)
			systemctl poweroff
      ;;
    $reboot)
		ans=$(confirm_exit &)
			systemctl reboot
      ;;
    $lock)
      dm-tool lock
      ;;
    $hibernate)
		ans=$(confirm_exit &)
      systemctl hibernate
      ;;
    $suspend)
		ans=$(confirm_exit &)
			mpc -q pause
			amixer set Master mute
			systemctl suspend
      ;;
    $logout)
		ans=$(confirm_exit &)
      sway exit
      ;;
esac
