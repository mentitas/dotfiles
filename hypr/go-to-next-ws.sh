#!/bin/sh

ws=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')

if [ "$ws" == "10" ]; then
	((ws=1))
else
	((ws=ws+1))
fi

hyprctl dispatch workspace $ws