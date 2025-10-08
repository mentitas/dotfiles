#!/usr/bin/env bash

if [ $(pidof xfce4-power-manager) ]; then
	notify-send -c "battery" -h string:x-dunst-stack-tag:"battery" "󱋙 Turning off Power Manager"
	eww update power-manager-active=false
	killall xfce4-power-manager

else
	notify-send -c "battery" -h string:x-dunst-stack-tag:"battery" "󰌪 Turning on Power Manager"
	eww update power-manager-active=true
	hyprctl dispatch exec xfce4-power-manager

fi