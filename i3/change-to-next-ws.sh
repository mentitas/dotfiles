#! /bin/bash

curr_ws=$(tail -n 1 /tmp/ws)
i3-msg workspace $(((curr_ws+1)%10))