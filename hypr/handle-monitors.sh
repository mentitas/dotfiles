#!/bin/sh

handle() {
  case $1 in
    monitoradded*)
      monitor_name=$(echo $1 | awk -F  ',' '{print $2}')
      if [ "$monitor_name" = "HDMI-A-1" ]; then
        eww open dock-m
      fi
    ;;

  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done