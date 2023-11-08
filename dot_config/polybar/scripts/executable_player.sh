#!/usr/bin/bash

STATUS=$(/usr/bin/playerctl status 2> /dev/null)
PAUSED="Paused :: "

if [[ "$STATUS" == "Playing" ]] ; then
  title=$(/usr/bin/playerctl metadata title)
  echo "Playing :: $title"
elif
  [[ "$STATUS" == "Paused" ]] ; then
  title=$(/usr/bin/playerctl metadata title)
  echo "Paused  :: $title"
else
  echo ""
fi
