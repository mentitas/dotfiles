#!/bin/sh

ws=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id')
echo $ws >> /tmp/ws