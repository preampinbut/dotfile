#!/bin/sh

usage() {
  echo "Usage: $0 [-g|--gifview] | [-m|--mpv] [-p|--padding] source source-width source-height screen-width screen-height"
  echo "Options:"
  echo "  -p, --padding set left padding; unset to auto padding base on HDMI-1"
  return
}

mode=""
padding_left="unset"

TEMP=$(getopt -o gmp: --long gifview,mpv,padding: -- "$@") || usage

eval set -- "$TEMP"

while true; do
  case "$1" in
    -g|--gifview)
      mode="gifview"
      shift
      ;;
    -m|--mpv)
      mode="mpv"
      shift
      ;;
    -p|--padding)
      padding_left=$2
      shift 2
      ;;
    --)
      shift
      break
      ;;
    *)
      usage
      exit 1
      ;;
  esac
done

if [ $# -ne 5 ]; then
  usage
  exit 1
fi

source=$1
source_width=$2
source_height=$3
screen_width=$4
screen_height=$5

if xrandr | grep -q "^HDMI-1 connected"; then
  if [ "$padding_left" = "unset" ]; then
    # Get the width of HDMI-1
    padding_left=$(xrandr | awk '/HDMI-1 connected/ { match($3, /^[0-9]+x/); print substr($3, RSTART, RLENGTH-1) }')
  fi
fi

g_width=$(( (screen_width/2) - (source_width/2) + padding_left ))
g_height=$(( (screen_height/2) - (source_height/2) ))

geo="${source_width}x${source_height}+${g_width}+${g_height}"

pkill xwinwrap

if [ "$mode" = "gifview" ]; then
  xwinwrap -g "$geo" -ov -ni -s -nf -- gifview -w WID "$source" -a
elif [ "$mode" = "mpv" ]; then
  xwinwrap -g "$geo" -ov -ni -s -nf -- mpv -wid WID --loop --no-audio "$source"
fi
