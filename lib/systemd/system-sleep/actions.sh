#!/bin/sh

export XDG_SEAT_PATH=/org/freedesktop/DisplayManager/Seat0

case "$1" in
    pre)
        /usr/bin/pkill spotifyd
        /usr/bin/sleep 1
        /usr/bin/dm-tool switch-to-greeter # protected by light-locker
        /usr/bin/sleep 1
        ;;
esac
