#!/bin/bash

# ==== SketchyBar Configuration Helpers ====
# Utility functions for common patterns and batch operations

source "$CONFIG_DIR/colors.sh"

# ==== BATCH OPERATIONS ====

# Function to configure multiple items at once with same properties
batch_configure() {
  local properties=("$@")
  local last_arg="${properties[-1]}"
  unset 'properties[-1]'  # Remove last element (item names)
  
  IFS=',' read -ra items <<< "$last_arg"
  
  for item in "${items[@]}"; do
    sketchybar --set "$item" "${properties[@]}"
  done
}

# Function to add multiple similar items
add_system_monitors() {
  local items=("cpu" "memory" "battery")
  
  for item in "${items[@]}"; do
    case "$item" in
      "cpu")
        sketchybar --add item cpu right \
                   --set cpu update_freq=2 \
                             icon=􀧓 \
                             script="$CONFIG_DIR/plugins/system_monitor.sh cpu"
        ;;
      "memory")
        sketchybar --add item memory right \
                   --set memory update_freq=2 \
                                icon=􀫦 \
                                script="$CONFIG_DIR/plugins/system_monitor.sh memory"
        ;;
      "battery")
        sketchybar --add item battery right \
                   --set battery update_freq=120 \
                                 script="$CONFIG_DIR/plugins/system_monitor.sh battery" \
                   --subscribe battery system_woke power_source_change
        ;;
    esac
  done
}

# ==== THEME SWITCHING ====

switch_theme() {
  local theme="$1"
  
  if [ -z "$theme" ]; then
    echo "Available themes: gray, teal, purple, blue, catppuccin, gruvbox"
    return 1
  fi
  
  # Update the theme in colors.sh
  sed -i '' "s/CURRENT_THEME=\".*\"/CURRENT_THEME=\"$theme\"/" "$CONFIG_DIR/colors.sh"
  
  # Reload SketchyBar
  sketchybar --reload
  
  echo "Switched to $theme theme"
}

# ==== MAINTENANCE FUNCTIONS ====

# Function to reload configuration
reload_config() {
  sketchybar --reload
  echo "SketchyBar configuration reloaded"
}

# Function to check SketchyBar status
status_check() {
  if pgrep -x "sketchybar" > /dev/null; then
    echo "✅ SketchyBar is running"
    sketchybar --query bar | jq -r '.height'
  else
    echo "❌ SketchyBar is not running"
  fi
}

# Function to restart SketchyBar
restart_sketchybar() {
  echo "Stopping SketchyBar..."
  killall sketchybar 2>/dev/null
  
  sleep 1
  
  echo "Starting SketchyBar..."
  sketchybar &
  
  echo "SketchyBar restarted"
}

# ==== COLOR UTILITIES ====

# Function to convert RGB to ARGB hex
rgb_to_argb() {
  local r="$1" g="$2" b="$3" a="${4:-255}"
  printf "0x%02x%02x%02x%02x" "$a" "$r" "$g" "$b"
}

# Function to show current theme colors
show_colors() {
  echo "Current theme colors:"
  echo "BAR_COLOR: $BAR_COLOR"
  echo "ITEM_BG_COLOR: $ITEM_BG_COLOR"
  echo "ACCENT_COLOR: $ACCENT_COLOR"
  echo "FG_COLOR: $FG_COLOR"
  echo "FG_MUTED: $FG_MUTED"
}

# ==== DEBUGGING ====

# Function to show all items and their properties
show_items() {
  echo "Current SketchyBar items:"
  sketchybar --query default | jq -r 'keys[]' | while read -r item; do
    echo "- $item"
  done
}

# Function to query specific item
query_item() {
  local item="$1"
  if [ -z "$item" ]; then
    echo "Usage: query_item <item_name>"
    return 1
  fi
  
  sketchybar --query "$item"
}

# ==== MAIN EXECUTION ====
case "$1" in
  "switch-theme")
    switch_theme "$2"
    ;;
  "reload")
    reload_config
    ;;
  "status")
    status_check
    ;;
  "restart")
    restart_sketchybar
    ;;
  "colors")
    show_colors
    ;;
  "items")
    show_items
    ;;
  "query")
    query_item "$2"
    ;;
  *)
    echo "SketchyBar Helpers"
    echo "Available commands:"
    echo "  switch-theme <theme>  - Switch color theme"
    echo "  reload                - Reload configuration"
    echo "  status               - Check SketchyBar status"
    echo "  restart              - Restart SketchyBar"
    echo "  colors               - Show current theme colors"
    echo "  items                - List all items"
    echo "  query <item>         - Query specific item"
    ;;
esac
