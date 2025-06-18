#!/bin/sh

notify-send -c 'bluetooth' -h string:x-dunst-stack-tag:'bluetooth' "Disconnecting from $2!"
bluetoothctl disconnect $1