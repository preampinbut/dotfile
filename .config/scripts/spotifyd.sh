#!/bin/bash

if [[ $1 == "--play-pause" ]] then
  playerctl --player=spotify,spotifyd play-pause
elif [[ $1 == "--next" ]] then
  playerctl --player=spotify,spotifyd next
elif [[ $1 == "--previous" ]] then
  playerctl --player=spotify,spotifyd previous
fi
