light=$(xbacklight -get)

# dunstify -a "change-light" -u low -i /home/rosu/.config/eww/icons/sun.svg -h string:x-dunst-stack-tag:"light" -h int:value:"$light" "Brightness: ${light}%" 
# dunstify -a "change_light" -u low -i /home/rosu/.config/eww/icons/sun.svg  -h string:x-dunst-stack-tag:"brightness" "Brightness: ${light}%
# $(for ((i=1; i<=$light/5; i++)); do echo -n "*"; done)"

#notify-send -c "light" -i /home/rosu/.config/eww/icons/sun.svg -h string:x-dunst-stack-tag:"brightness" "Brightness: $(($light))%" -h int:value:$((light))

notify-send -c "light" -h string:x-dunst-stack-tag:"brightness" "Brightness: $(($light))%
$(for ((i=1; i<=$light/5; i++)); do echo -n " "; done)"

eww update backlight=$light