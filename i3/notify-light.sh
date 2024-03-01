msgTag="mylight"
light=$(xbacklight -get)

dunstify -a "change-light" -u low -i /home/rosu/.config/eww/icons/sun.png -h string:x-dunst-stack-tag:$msgTag -h int:value:"$light" "Brightness: ${light}%" 