#! /bin/bash

if $(pamixer --get-mute)
then
    pamixer -u
else
    pamixer -m
fi