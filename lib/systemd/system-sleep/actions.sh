#!/bin/sh

export XDG_SEAT_PATH=/org/freedesktop/DisplayManager/Seat0

case "$1" in
    pre)
        /usr/bin/pkill spotifyd
        ;;
esac
