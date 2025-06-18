#!/usr/bin/env bash

# Va leyendo el nombre de las ventanas, y si la ventana se llama vivaldi le cambia el tema
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
  stdbuf -o0 awk -F '>>|,' -e '/^activewindow>>/ {print $2}' |
  while IFS= read -r window_name; do
    
    if [ "$window_name" = "vivaldi-stable" ]
    then
        sleep 0.3
        active_workspace=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')
        
        #           ctrl alt  shift                         ctrl alt  shift
        ydotool key 29:1 56:1 42:1 $((active_workspace+1)):1 29:0 56:0 42:0 $((active_workspace+1)):0
        ydotool key 29:1 42:1 23:1 29:0 42:0 23:0
        ydotool key 29:1 28:1 29:0 28:0
    fi
  done