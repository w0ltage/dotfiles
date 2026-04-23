#!/bin/bash

# ==== SketchyBar Space Controller ====
# Updates space icons based on Aerospace window data
# Subscribed to: space_windows_change, aerospace_workspace_change

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/plugins/icon_map_fn.sh"

# Fetch focused workspace (fallback to CLI if empty)
if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

# Debug logging
echo "Focused: $FOCUSED_WORKSPACE" > /tmp/sketchy_debug.log

# Fetch all windows once
window_data=$(aerospace list-windows --all --format "%{workspace}|%{app-name}|%{app-bundle-id}")

# Create an array to store app lists per workspace (Bash 3.2 compatible - sparse array)
# Note: This assumes workspace IDs are integers!
workspace_apps=()
workspace_has_ghostty=()

while IFS='|' read -r sid app_name app_bundle_id; do
  if [ -n "$sid" ] && [ -n "$app_name" ]; then
    if [ "$app_bundle_id" = "com.mitchellh.ghostty" ]; then
      if [ "${workspace_has_ghostty[$sid]}" = "1" ]; then
        continue
      fi

      workspace_has_ghostty[$sid]="1"
    fi

    icon_map "$app_name"
    # Append icon to the workspace's entry (handling potential previous value)
    current_icons="${workspace_apps[$sid]}"
    workspace_apps[$sid]="$current_icons $icon_result"
  fi
done <<< "$window_data"

# Iterate over all workspaces and update sketchybar
for sid in $(aerospace list-workspaces --all); do
  icon_strip="${workspace_apps[$sid]}"

  # Determine highlight state
  if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set space.$sid background.drawing=on \
                         background.color=$ACCENT_COLOR \
                         label.color=$COLOR_ACTIVE_TEXT \
                         icon.color=$COLOR_ACTIVE_TEXT \
                         label="$icon_strip"
  else
    sketchybar --set space.$sid background.drawing=off \
                         label.color=$COLOR_INACTIVE \
                         icon.color=$COLOR_INACTIVE \
                         label="$icon_strip"
  fi
done
