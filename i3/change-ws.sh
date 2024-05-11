#! /bin/bash

# $1 is the new workspace
# $1 could be a ws name, "prev", "next", "up" or "down"

old_ws=$(tail -n 1 /tmp/ws)

case "$1" in
    "next" | "up"  ) new_ws=$(((old_ws+1)%10)) ;;
    "prev" | "down") 
        if [ $old_ws = 0 ]
        then
            new_ws=9
        else
            new_ws=$((old_ws-1))
        fi                       ;;
    *)      new_ws=$1            ;;
esac

if ( $new_ws < 0 )
then
    new_ws=$new_ws+10
fi

# Change into the new workspace
i3-msg workspace $new_ws

# Save the new workspace
#echo $new_ws >> /tmp/ws

# Get the theme
current_theme=$(tail -n 1 /tmp/theme)


### Change the themes ###

# Change eww accent color
#color=$(~/.config/i3/get-ws-color.sh $1)
# echo "\$ws: $1;" > ~/.config/eww/_ws.scss

## Change eww accent color
#color=$(~/.config/i3/get-ws-color.sh $1)
#echo "\$accent: $color;" > ~/.config/eww/_theme.scss

## Change rofi accent color
color=$(~/.config/i3/get-ws-color.sh $new_ws)

echo "*{
    urgent:     $color;
}" > ~/.config/rofi/accent.rasi


# Switch Vivaldi theme
sleep 0.2
if [ "$current_theme" = "dark" ]
then
    echo $new_ws
    xdotool search --onlyvisible --name "Vivaldi" windowactivate && xdotool key alt+ctrl+shift+$new_ws
else
    xdotool search --onlyvisible --name "Vivaldi" windowactivate && xdotool key alt+ctrl+shift+L
fi


# Catppuccin
# case $1 in
#     1) color_rgb="--border-red 203 --border-green 166 --border-blue 247" ;;
#     2) color_rgb="--border-red 245 --border-green 194 --border-blue 231" ;;
#     3) color_rgb="--border-red 243 --border-green 139 --border-blue 168" ;;
#     4) color_rgb="--border-red 250 --border-green 179 --border-blue 135" ;;
#     5) color_rgb="--border-red 249 --border-green 226 --border-blue 175" ;;
#     6) color_rgb="--border-red 166 --border-green 227 --border-blue 161" ;;
#     7) color_rgb="--border-red 148 --border-green 226 --border-blue 213" ;;
#     8) color_rgb="--border-red 137 --border-green 220 --border-blue 235" ;;
#     9) color_rgb="--border-red 116 --border-green 199 --border-blue 236" ;;
#     *) color_rgb="--border-red 137 --border-green 180 --border-blue 250" ;;
# esac

# Change xborders
killall xborders

if [ "$current_theme" = "dark" ]
then
    # New Catppuccin
    # https://colorkit.co/color-palette-generator/b688ea-e8a3d4-eb6c8f-f19d69-edd090-89db80-53c9b4-6bd2e3-56bae6-6c9eef/
    case $new_ws in
        1) color_rgb="--border-red 182 --border-green 136 --border-blue 234" ;;
        2) color_rgb="--border-red 232 --border-green 163 --border-blue 212" ;;
        3) color_rgb="--border-red 235 --border-green 108 --border-blue 143" ;;
        4) color_rgb="--border-red 241 --border-green 157 --border-blue 105" ;;
        5) color_rgb="--border-red 237 --border-green 208 --border-blue 144" ;;
        6) color_rgb="--border-red 137 --border-green 219 --border-blue 128" ;;
        7) color_rgb="--border-red 83  --border-green 201 --border-blue 180" ;;
        8) color_rgb="--border-red 107 --border-green 210 --border-blue 227" ;;
        9) color_rgb="--border-red 86  --border-green 186 --border-blue 230" ;;
        *) color_rgb="--border-red 108 --border-green 158 --border-blue 239" ;;
    esac
else
    # New Mocha light
    # //https://colorkit.co/color-palette-generator/af61fd-fe79d5-ff4876-ff924a-ffd36b-5bfc4c-15fad5-40dffd-2fbcfd-4c8dfd/
    case $new_ws in
        1) color_rgb="--border-red 185 --border-green 106 --border-blue 227" ;;
        2) color_rgb="--border-red 253 --border-green 127 --border-blue 192" ;;
        3) color_rgb="--border-red 253 --border-green  85 --border-blue 110" ;; 
        4) color_rgb="--border-red 253 --border-green 148 --border-blue  73" ;;
        5) color_rgb="--border-red 253 --border-green 204 --border-blue 101" ;;
        6) color_rgb="--border-red 112 --border-green 240 --border-blue  74" ;; 
        7) color_rgb="--border-red  52 --border-green 238 --border-blue 192" ;; 
        8) color_rgb="--border-red  89 --border-green 215 --border-blue 227" ;; 
        9) color_rgb="--border-red  74 --border-green 185 --border-blue 227" ;; 
        *) color_rgb="--border-red  99 --border-green 144 --border-blue 227" ;; 
    esac
fi

xborders --border-mode outside --border-radius 17 --border-width 3 $color_rgb
