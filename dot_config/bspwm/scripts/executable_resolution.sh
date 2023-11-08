#!/bin/bash

# run command only if it's not already running on the system
run() { 
  # if a process is already running, then `pgrep` will return failure 
  # instead of success because of "!"
  # then "$@" will run passed arguments (command), if `pgrep` return success
  ! pgrep -f "$1" >/dev/null && "$@"; 
}

# sanity check that spice-vdagent properly started
spice-vdagent &
run $HOME/.config/bspwm/scripts/polybar_reload.sh > /dev/null 2>&1 &

while true; do
    while read -r output; do
        xrandr --output $output --auto
    done < <(xrandr | grep " connected" | awk '{print $1;}')
    sleep 1
done

