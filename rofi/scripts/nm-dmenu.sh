#!/bin/bash

networkmanager_output=$(networkmanager_dmenu -i -n)

if [ -n "$networkmanager_output" ]; then
  selected=$(echo "$networkmanager_output" | rofi -dmenu -p "Network:" )
  if [ -n "$selected" ]; then
    echo "$selected" | networkmanager_dmenu --action=activate
  fi
fi