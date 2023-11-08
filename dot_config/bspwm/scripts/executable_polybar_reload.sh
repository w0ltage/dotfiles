#!/bin/bash

while true; do
    INITIAL_RESOLUTION=`xrandr | sed -n '2 p'`
    NEW_RESOLUTION=`xrandr | sed -n '2 p'`

    while true; do

        if [ "$INITIAL_RESOLUTION" != "$NEW_RESOLUTION" ]; then
            polybar-msg cmd restart
            nitrogen --restore
            INITIAL_RESOLUTION=$NEW_RESOLUTION
        else
            NEW_RESOLUTION=`xrandr | sed -n '2 p'`
        fi
        
        sleep 1
    done
done
