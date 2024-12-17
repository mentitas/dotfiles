volume=$(pamixer --get-volume)
mute=$(pamixer --get-mute)

if [[ "$mute" == "true" ]];
then
    level='0'
elif [[ "$volume" -gt 50 ]];
then
    level='2'
elif [[ "$volume" -gt 1 ]];
then
    level='1'
else
    level='0'
fi

#dunstify -a "change_volume" -u low -i /home/rosu/.config/eww/icons/volume-$level.svg -h string:x-dunst-stack-tag:"volume" -h int:value:"$volume" "Volume: ${volume}%" 
#dunstify -a "change_volume" -u low -i /home/rosu/.config/eww/icons/volume-$level.svg -u low -h string:x-dunst-stack-tag:"volume" "Volume: ${volume}%
#$(for ((i=1; i<=$volume/10; i++)); do echo -n " "; done)"

#notify-send -c "volume" -i /home/rosu/.config/eww/icons/volume-$level.svg -h string:x-dunst-stack-tag:"volume" "Volume: $(($volume))%" -h int:value:$((volume))
notify-send -c "volume" -h string:x-dunst-stack-tag:"volume" "Volume: $(($volume))%
$(for ((i=1; i<=$volume/10; i++)); do echo -n " "; done)"
