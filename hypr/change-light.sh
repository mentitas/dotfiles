#!/usr/bin/env bash

if [[ "$1" == "up" ]]; then  
    xbacklight -inc 1
elif [[ "$1" == "down" ]]; then
    xbacklight -dec 1
fi

light=$(xbacklight -get)
heart=" "
heart="󰣏 "
heart="󰋑 "

heart_string=""
for ((i=1; i<=$light/10; i++)); do
    heart_string=$heart_string$"󰋑 "
done

if [ $((light % 10)) -ge 5 -a $((light % 10)) -lt 10 ]; then
    heart_string=$heart_string$"󰛞 "
fi

for ((i=$light/10; ${#heart_string}<20; i++)); do
    heart_string=$heart_string$"󰋕 "
done

notify-send -c "light" -h string:x-dunst-stack-tag:"brightness" "Brightness: $(($light))%
$(echo -n $heart_string;)"

eww update backlight=$light