#!/bin/bash

# ==== SketchyBar Spaces Component ====
# Unified component with definition and update logic

source "$CONFIG_DIR/colors.sh"

# Add the event if it doesn't exist (ignore error if it does)
sketchybar --add event aerospace_workspace_change || true

# Remove previously generated space items so stale items don't survive reloads.
while IFS= read -r item; do
  [ -n "$item" ] || continue
  sketchybar --remove "$item" || true
done < <(sketchybar --query bar 2>/dev/null | tr ',' '\n' | sed -n 's/.*"\(space\.[^"]*\)".*/\1/p')

sketchybar --remove space_separator || true

# ==== SPACE ITEM DEFINITIONS ====
# Loop through monitors to get workspaces for each specific display
for m in $(aerospace list-monitors --format %{monitor-id}); do
  for sid in $(aerospace list-workspaces --monitor $m); do
    sketchybar --add item space.$sid left \
               --set space.$sid \
                                display=$m \
                                icon=$sid \
                                icon.font="SF Mono:SemiBold:14.0" \
                                icon.color=$COLOR_INACTIVE \
                                icon.padding_right=-1 \
                                label.font="sketchybar-app-font:SF Pro:16.0" \
                                label.color=$COLOR_INACTIVE \
                                label.y_offset=-1 \
                                label.padding_right=35 \
                                click_script="aerospace workspace $sid"
  done
done

# Add space separator
sketchybar --add item space_separator left \
           --set space_separator icon="􀆊" \
                                 icon.color=$ACCENT_COLOR \
                                 icon.padding_left=4 \
                                 label.drawing=off \
                                 background.drawing=off \
                                 script="$PLUGIN_DIR/space_controller.sh" \
           --subscribe space_separator space_windows_change aerospace_workspace_change

# ==== UPDATE LOGIC ====
