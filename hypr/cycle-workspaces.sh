#!/usr/bin/env bash


open=$(eww active-windows | grep workspace-overview)

if [ "$open" == "" ]; then
	eww open workspace-overview
fi

if [ "$1" = "next" ]; then
	hyprctl dispatch workspace e+1
elif [ "$1" = "prev" ]; then
	hyprctl dispatch workspace e-1
fi