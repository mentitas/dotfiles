#!/usr/bin/env bash

actual_theme=$(gsettings get org.gnome.desktop.interface gtk-theme)

if [ "$actual_theme" = "'se98'" ]; then
	notify-send -h string:x-dunst-stack-tag:"theme" "Changing theme to 'Catppuccin'"
	gsettings set org.gnome.desktop.interface gtk-theme Catppuccin-Dark
	gsettings set org.gnome.desktop.interface icon-theme Colloid-Purple-Catppuccin-Dark
	# swaybg -i /home/rosu/Pictures/field1.webp

else
	notify-send -h string:x-dunst-stack-tag:"theme" "Changing theme to 'se98'"
	gsettings set org.gnome.desktop.interface gtk-theme  se98
	gsettings set org.gnome.desktop.interface icon-theme se98
	# swaybg -i /home/rosu/Pictures/field2.jpg
	#gsettings set org.gnome.desktop.interface icon-theme pixelitos
fi