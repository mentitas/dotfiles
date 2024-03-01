msgTag="myvolume"
volume=$(pamixer --get-volume)
mute=$(pamixer --get-mute)

if [[ "$mute" == "true" ]];
then
    level='mute'
elif [[ "$volume" -gt 66 ]];
then
    level='3'
elif [[ "$volume" -gt 33 ]];
then
    level='2'
elif [[ "$volume" -gt 1 ]];
then
    level='1'
else
    level='0'
fi

dunstify -a "change-volume" -u low -i /home/rosu/.config/eww/icons/volume-$level.png -h string:x-dunst-stack-tag:$msgTag -h int:value:"$volume" "Volume: ${volume}%" 