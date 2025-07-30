#!/usr/bin/env bash

# $1 = "drun" o $1 = "window"

# Change rofi accent color
# colors=("cba6f7" "f5c2e7" "f38ba8" "fab387" "f9e2af" "a6e3a1" "94e2d5" "89dceb" "74c7ec" "89b4fa")
# current_workspace=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')
# current_color=${colors[(($current_workspace-1))]}

# echo "* { selected: #${current_color}; }" > /home/rosu/.config/rofi/accent.rasi

# eww update bar-visibility=false \
# && rofi -show $1 -config "~/.config/rofi/style.rasi" \
# && eww update bar-visibility=true


rofi -show $1 -config "~/.config/rofi/another-style.rasi" -icon-theme "Colloid-Purple-Catppuccin-Dark" -calc-command "echo -n '{result}' | wl-copy"

# tofi-drun --drun-launch=true
