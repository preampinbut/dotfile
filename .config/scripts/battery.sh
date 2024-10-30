#!/bin/bash

status=$(cat /sys/class/power_supply/BAT0/status)
energy_full=$(cat /sys/class/power_supply/BAT0/energy_full)
energy_now=$(cat /sys/class/power_supply/BAT0/energy_now)

# 10%
threshold_1=$((energy_full / 10 ))
# 20%
threshold_2=$((energy_full / 20 ))

if [ "$status" = "Discharging" ] && [ "$energy_now" -lt "$threshold_1" ]; then
  /usr/bin/xbacklight -set 25
elif [ "$status" = "Discharging" ] && [ "$energy_now" -lt "$threshold_2" ]; then
  systemctl hibernate
fi
  
