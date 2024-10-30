#!/bin/sh

pkill xwinwrap

source=$1

source_width=$2
source_height=$3

screen_width=$4
screen_height=$5

padding_left=${6:-0}

if xrandr | grep -q "^HDMI-1 connected"; then
  if [ "$padding_left" -ne -1 ]; then
    # Get the width of HDMI-1
    padding_left=$(xrandr | awk '/HDMI-1 connected/ { match($3, /^[0-9]+x/); print substr($3, RSTART, RLENGTH-1) }')
  fi
fi

g_width=$(( (screen_width/2) - (source_width/2) + padding_left ))
g_height=$(( (screen_height/2) - (source_height/2) ))

geo="${source_width}x${source_height}+${g_width}+${g_height}"

xwinwrap -g "$geo" -ov -ni -s -nf -- gifview -w WID "$source" -a
