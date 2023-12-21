#!/bin/bash

usage() {
  echo "Usage: $0 [-d]" 1>&2
  exit 1
}

change_wallpaper() {
  if [ "$1" -eq 0 ]; then
    echo "wallengine disable"
    feh --bg-max /home/preampinbut/Pictures/zzz/yor.png
  elif [ "$1" -eq 1 ]; then
    echo "wallengine enable"
    /usr/bin/nohup /home/preampinbut/.config/scripts/wallengine.sh 25 &> /dev/null & disown
  fi
}

monitor_power_status() {
  local prev_power_status=$(cat /sys/class/power_supply/ADP1/online)

  while true; do
    local power_status=$(cat /sys/class/power_supply/ADP1/online)

    if [ "$power_status" -ne "$prev_power_status" ]; then
      echo "kill wallengine"
      pkill -x wallengine
      sleep 1
      change_wallpaper "$power_status"
      prev_power_status=$power_status
    fi

    sleep 3
  done
}

run_in_background=false

while getopts ":d" opt; do
  case $opt in
    d)
      run_in_background=true
      ;;
    *)
      usage
      ;;
  esac
done

if [ "$run_in_background" = false ]; then
  echo "kill wallengine"
  pkill -x wallengine
fi

change_wallpaper "$(cat /sys/class/power_supply/ADP1/online)"

if [ "$run_in_background" = false ]; then
  exit 0
fi

monitor_power_status
