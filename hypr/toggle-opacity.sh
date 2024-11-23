#!/usr/bin/env sh
OPACITY=$(hyprctl getoption decoration:active_opacity 1 | awk 'NR==1{print $2}')
if [ "$OPACITY" != 1.000000 ] ; then
    hyprctl --batch "\
        keyword decoration:active_opacity 1;\
        keyword decoration:inactive_opacity 1;\
        keyword decoration:fullscreen_opacity 1"
    exit
fi
hyprctl reload