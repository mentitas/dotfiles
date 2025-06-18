#!/bin/sh

notify-send -c 'bluetooth' -h string:x-dunst-stack-tag:'bluetooth' "Connecting to $2!"
bluetoothctl connect $1