#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar on the main monitor
polybar -c $HOME/.config/polybar/config.ini --reload main &

# Launch bar1 and bar2
if [[ $(xrandr -q | grep 'VGA1 connected') ]]; then
  polybar -c $HOME/.config/polybar/config.ini --reload external &
fi

echo "Bars launched..."
