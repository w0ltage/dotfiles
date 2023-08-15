#!/bin/sh

GAP=$1
SPACES=$(bspc query -D)

for SPACE in $SPACES
do
    bspc config -d ${SPACE} window_gap $GAP
done
