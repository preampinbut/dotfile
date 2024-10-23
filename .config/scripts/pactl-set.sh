#!/bin/sh

max_volume=100 # in percent

sink="@DEFAULT_SINK@"

pactl set-sink-volume $sink $1

volume=$(pactl get-sink-volume $sink | head -n1 | cut -d/ -f2 | tr -d ' %');
if (( volume > max_volume )); then
    pactl set-sink-volume $sink $max_volume%;
fi;
