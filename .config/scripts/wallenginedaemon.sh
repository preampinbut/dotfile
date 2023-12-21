#!/bin/bash

prev_power_status=$(cat /sys/class/power_supply/ADP1/online)
if [ "$prev_power_status" -eq 0 ]; then
  echo "wallengine 0"
  /usr/bin/nohup /home/preampinbut/.config/scripts/wallengine.sh 6 &> /dev/null & disown
elif [ "$prev_power_status" -eq 1 ]; then
  echo "wallengine 1"
  /usr/bin/nohup /home/preampinbut/.config/scripts/wallengine.sh 25 &> /dev/null & disown
fi

while true; do
  power_status=$(cat /sys/class/power_supply/ADP1/online)

  if [ "$power_status" -ne "$prev_power_status" ]; then
    echo "kill wallengine"
    pkill -x wallengine
    sleep 1
    if [ "$power_status" -eq 0 ]; then
      echo "wallengine 0"
      /usr/bin/nohup /home/preampinbut/.config/scripts/wallengine.sh 6 &> /dev/null & disown
    elif [ "$power_status" -eq 1 ]; then
      echo "wallengine 1"
      /usr/bin/nohup /home/preampinbut/.config/scripts/wallengine.sh 25 &> /dev/null & disown
    fi

    prev_power_status=$power_status
  fi

  sleep 3
done
