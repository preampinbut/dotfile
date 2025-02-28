#!/bin/bash

config_file="$HOME/.config/linux-wallpaperengine/config"

adp=$(grep "^adp:" "$config_file" | awk '{print $2}')

if [ -z "$adp" ]; then
  echo "Error: Value for key \"adp\" not found in the config file."
  exit 1
fi

usage() {
  echo "Usage: $0 [-d]" 1>&2
  exit 1
}

use_feh() {
  bg=$(grep "^bg:" "$config_file" | awk '{print $2}')

  # Check if the value is not empty
  if [ -n "$bg" ]; then
      # Use the value in your command
    feh --bg-max $bg
  else
    echo "Warning: Value for key \"bg\" not found in the config file."
  fi
}

use_wall() {
  id=$(grep "^id:" "$config_file" | awk '{print $2}')

  # Check if the value is not empty
  if [ -n "$id" ]; then
      # Use the value in your command
    /usr/bin/nohup $HOME/.config/linux-wallpaperengine/wallpaperengine.sh $1 $id &> /dev/null & disown
  else
    echo "Error: Value for key \"id\" not found in the config file."
  fi
}

change_wallpaper() {
  disabled=$(grep "^disabled:" "$config_file" | awk '{print $2}')

  if [ -n "$disabled" ]; then
    if [ "$disabled" -eq 1 ]; then
      use_feh
      return
    fi
  fi

  if [ "$1" -eq 0 ]; then
    echo "linux-wallpaperengine disable"
    use_feh
  elif [ "$1" -eq 1 ]; then
    echo "linux-wallpaperengine enable"
    use_wall 25
  fi
}

monitor_power_status() {
  local prev_power_status=$(cat "$adp")

  while true; do
    local power_status=$(cat "$adp")

    if [ "$power_status" -ne "$prev_power_status" ]; then
      echo "kill linux-wallpaper"
      pkill -x linux-wallpaper
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
  echo "kill linux-wallpaper"
  pkill -x linux-wallpaper
fi

change_wallpaper "$(cat $adp)"

if [ "$run_in_background" = false ]; then
  exit 0
fi

monitor_power_status
