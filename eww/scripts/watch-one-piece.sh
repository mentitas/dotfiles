#!/usr/bin/env bash

hyprctl dispatch workspace 3
hyprctl dispatch exec thunar /home/rosu/Videos/OnePiece
hyprctl dispatch workspace 2
hyprctl dispatch exec vesktop
hyprctl dispatch workspace 1 
hyprctl dispatch exec vlc /home/rosu/Videos/OnePiece *.mkv