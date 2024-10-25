#!/bin/sh

pkill xwinwrap

source=$1

source_width=$2
source_height=$3

screen_width=$4
screen_height=$5

g_width=$(( (screen_width/2) - (source_width/2) ))
g_height=$(( (screen_height/2) - (source_height/2) ))

geo="${source_width}x${source_height}+${g_width}+${g_height}"

xwinwrap -g "$geo" -ov -ni -s -nf -- gifview -w WID "$source" -a
