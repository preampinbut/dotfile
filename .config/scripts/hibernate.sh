#!/bin/bash
pkill spotifyd
sleep 1
dm-tool lock && systemctl hibernate
