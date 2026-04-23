#!/bin/bash

# ==== SketchyBar Space Highlighting ====
# Handles only the space_change event to highlight the active space

# Handle space selection highlighting
source "$CONFIG_DIR/colors.sh"

# Argument passed from items/spaces.sh
sid="$1"

# If FOCUSED_WORKSPACE is not set (e.g. manual reload), fetch it
if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" background.drawing=on \
                           background.color=$ACCENT_COLOR \
                           label.color=$COLOR_ACTIVE_TEXT \
                           icon.color=$COLOR_ACTIVE_TEXT
else
  sketchybar --set "$NAME" background.drawing=off \
                           label.color=$COLOR_INACTIVE \
                           icon.color=$COLOR_INACTIVE
fi
