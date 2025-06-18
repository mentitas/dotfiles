#!/usr/bin/env bash

while true;
do

  /home/rosu/Software/mouse-actions 2>&1 >/dev/null |
    while IFS= read -r output; do
  
      if [ "${output:0:7}" = "X Error" ]
      then
          notify-send "Oh no!" "MouseActions died! "
          killall mouse-actions
          break
      fi
    done

  notify-send "Yay!" "MouseActions is alive again! 󰱨"

done