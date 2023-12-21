#!/bin/sh

case "$1" in
    pre)
        /usr/bin/pkill spotifyd
        ;;
esac
