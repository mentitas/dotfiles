#! /bin/bash

# $1 is the new workspace

# Change into the new workspace
i3-msg workspace $1

# Save the new workspace
echo $1 >> /tmp/ws


### Change the themes ###

# Switch Vivaldi theme
sleep 0.2
xdotool search --onlyvisible --name "Vivaldi" windowactivate && xdotool key alt+ctrl+shift+$1

# Change eww accent color
#color=$(~/.config/i3/get-ws-color.sh $1)
# echo "\$ws: $1;" > ~/.config/eww/_ws.scss

## Change eww accent color
#color=$(~/.config/i3/get-ws-color.sh $1)
#echo "\$accent: $color;" > ~/.config/eww/_theme.scss

## Change rofi accent color
color=$(~/.config/i3/get-ws-color.sh $1)

echo "*{
    urgent:     $color;
}" > ~/.config/rofi/accent.rasi

# Change xborders
killall xborders

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

# New Catppuccin
# https://colorkit.co/color-palette-generator/b688ea-e8a3d4-eb6c8f-f19d69-edd090-89db80-53c9b4-6bd2e3-56bae6-6c9eef/

case $1 in
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

xborders --border-mode outside --border-radius 13 --border-width 3 $color_rgb