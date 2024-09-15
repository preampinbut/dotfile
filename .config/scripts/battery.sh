#!/bin/bash

status=$(cat /sys/class/power_supply/BAT0/status)
energy_full=$(cat /sys/class/power_supply/BAT0/energy_full)
energy_now=$(cat /sys/class/power_supply/BAT0/energy_now)

threshold=$((energy_full / 10 ))

if [ "$status" = "Discharging" ] && [ "$energy_now" -lt "$threshold" ]; then
  /usr/bin/xbacklight -set 25
fi
