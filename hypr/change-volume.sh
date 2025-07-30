#!/usr/bin/env bash

if [ "$1" = "up" ]; then
    pamixer -i 5
elif [ "$1" = "down" ]; then
    pamixer -d 5
else
    pamixer -t
fi

volume=$(pamixer --get-volume)
mute=$(pamixer --get-mute)

heart=" "
heart="󰝚 "
heart="󰣏 "
heart="󰋑 "
muted=""

if [[ "$mute" == "true" ]];
then
    level='0'
    heart="󰝛 "
    heart="♥ "
    heart="󱀝 "
    heart="󰋕 "
    muted="(muted)"

elif [[ "$volume" -gt 50 ]];
then
    level='2'
elif [[ "$volume" -gt 1 ]];
then
    level='1'
else
    level='0'
fi

heart_string=""
for ((i=1; i<=$volume/10; i++)); do
    heart_string=$heart_string$"󰋑 "
done

if [ $((volume % 10)) -ge 5 -a $((volume % 10)) -lt 10 ]; then
    heart_string=$heart_string$"󰛞 "
fi

for ((i=$volume/10; ${#heart_string}<20; i++)); do
    heart_string=$heart_string$"󰋕 "
done



notify-send -c "volume" -h string:x-dunst-stack-tag:"volume" "Volume: $(($volume))% $muted
$(echo -n $heart_string;)"

eww update volume=$volume
eww update mute=$mute

#dunstify -a "change_volume" -u low -i /home/rosu/.config/eww/icons/volume-$level.svg -h string:x-dunst-stack-tag:"volume" -h int:value:"$volume" "Volume: ${volume}%" 
#dunstify -a "change_volume" -u low -i /home/rosu/.config/eww/icons/volume-$level.svg -u low -h string:x-dunst-stack-tag:"volume" "Volume: ${volume}%
#$(for ((i=1; i<=$volume/10; i++)); do echo -n " "; done)"

#notify-send -c "volume" -i /home/rosu/.config/eww/icons/volume-$level.svg -h string:x-dunst-stack-tag:"volume" "Volume: $(($volume))%" -h int:value:$((volume))
