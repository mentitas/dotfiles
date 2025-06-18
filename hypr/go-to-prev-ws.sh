#!/bin/sh

ws=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')

if [ "$ws" -eq "1" ]; then
	ws=10
else
	ws=$((ws - 1))
fi

hyprctl dispatch workspace $ws