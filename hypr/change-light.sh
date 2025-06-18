#!/usr/bin/env bash

if [[ "$1" == "up" ]]; then  
    xbacklight -inc 1
elif [[ "$1" == "down" ]]; then
    xbacklight -dec 1
fi

light=$(xbacklight -get)
heart=" "

notify-send -c "light" -h string:x-dunst-stack-tag:"brightness" "Brightness: $(($light))%
$(for ((i=1; i<=$light/5; i++)); do echo -n "$heart"; done)"

eww update backlight=$light