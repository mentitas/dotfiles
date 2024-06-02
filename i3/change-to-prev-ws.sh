#! /bin/bash

curr_ws=$(tail -n 1 /tmp/ws)

if [ $((curr_ws)) == 0 ]; then
	((curr_ws=10))
fi

i3-msg workspace $(((curr_ws-1)%10))