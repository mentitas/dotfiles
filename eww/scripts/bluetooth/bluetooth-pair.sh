#!/bin/sh

notify-send -c 'bluetooth' -h string:x-dunst-stack-tag:'bluetooth' "Pairing with $2"
bluetoothctl pair $1