#! /bin/bash

# $1 is the new workspace
# $1 could be a ws name, "prev" or "next"

old_ws=$(tail -n 1 /tmp/ws)

case "$1" in
    "next") 
        if [ $old_ws = 9 ]
        then
            new_ws=0
        else
            new_ws=$((old_ws+1))
        fi                       ;;
    "prev") 
        if [ $old_ws = 0 ]
        then
            new_ws=9
        else
            new_ws=$((old_ws-1))
        fi                       ;;
esac

# Change into the new workspace
i3-msg move container to workspace $new_ws