#!/bin/bash

# ==== SketchyBar Color Configuration ====
# Clean, theme-based color management

# Current active theme - change this to switch themes
CURRENT_THEME="gray"

# Theme definitions
case "$CURRENT_THEME" in
  "gray")
    export BAR_COLOR=0xff101314
    export ITEM_BG_COLOR=0xff353c3f
    export ACCENT_COLOR=0xffffffff
    export FG_COLOR=0xffffffff
    export FG_MUTED=0xccffffff
    export FG_STRONG=0xffffffff
    export WARN_COLOR=0xffff4d4d
    
    # UI Hierarchy Colors
    export COLOR_PRIMARY=0xffffffff      # Pure white - time/date (anchor)
    export COLOR_SECONDARY=0xdddddddd   # Slightly dimmed - CPU/RAM/Vol/Kb
    export COLOR_INACTIVE=0xffCCCCCC   # Dim white - inactive workspaces
    export COLOR_ACTIVE_TEXT=0xff000000  # Black text on accent background
    ;;
  
  "teal")
    export BAR_COLOR=0xff001f30
    export ITEM_BG_COLOR=0xff003547
    export ACCENT_COLOR=0xff2cf9ed
    export FG_COLOR=0xffffffff
    export FG_MUTED=0xccffffff
    export FG_STRONG=0xffffffff
    export WARN_COLOR=0xffff4d4d
    
    # UI Hierarchy Colors
    export COLOR_PRIMARY=0xffffffff      # Pure white - time/date (anchor)
    export COLOR_SECONDARY=0xffcdd6f4    # Slightly dimmed - CPU/RAM/Vol/Kb
    export COLOR_INACTIVE=0xffaaaaaa     # Dim white - inactive workspaces
    export COLOR_ACTIVE_TEXT=0xff000000  # Black text on accent background
    ;;
  
  "purple")
    export BAR_COLOR=0xff140c42
    export ITEM_BG_COLOR=0xff2b1c84
    export ACCENT_COLOR=0xffeb46f9
    export FG_COLOR=0xffffffff
    export FG_MUTED=0xccFFF9F9
    export FG_STRONG=0xffffffff
    export WARN_COLOR=0xffff4d4d
    
    # UI Hierarchy Colors
    export COLOR_PRIMARY=0xffffffff      # Pure white - time/date (anchor)
    export COLOR_SECONDARY=0xffcdd6f4    # Slightly dimmed - CPU/RAM/Vol/Kb
    export COLOR_INACTIVE=0xffaaaaaa     # Dim white - inactive workspaces
    export COLOR_ACTIVE_TEXT=0xff000000  # Black text on accent background
    ;;
  
  "blue")
    export BAR_COLOR=0xff021254
    export ITEM_BG_COLOR=0xff093aa8
    export ACCENT_COLOR=0xff15bdf9
    export FG_COLOR=0xffffffff
    export FG_MUTED=0xccffffff
    export FG_STRONG=0xffffffff
    export WARN_COLOR=0xffff4d4d
    
    # UI Hierarchy Colors
    export COLOR_PRIMARY=0xffffffff      # Pure white - time/date (anchor)
    export COLOR_SECONDARY=0xffcdd6f4    # Slightly dimmed - CPU/RAM/Vol/Kb
    export COLOR_INACTIVE=0xffaaaaaa     # Dim white - inactive workspaces
    export COLOR_ACTIVE_TEXT=0xff000000  # Black text on accent background
    ;;
  
  "catppuccin")
    export BAR_COLOR=0xff1e1e2e
    export ITEM_BG_COLOR=0xff313244
    export ACCENT_COLOR=0xff89b4fa      # Catppuccin Blue
    export FG_COLOR=0xffcdd6f4
    export FG_MUTED=0xff9399b2
    export FG_STRONG=0xffffffff
    export WARN_COLOR=0xfff38ba8
    
    # UI Hierarchy Colors
    export COLOR_PRIMARY=0xffffffff      # Pure white - time/date (anchor)
    export COLOR_SECONDARY=0xffcdd6f4    # Catppuccin Text - CPU/RAM/Vol/Kb
    export COLOR_INACTIVE=0xff9399b2     # Catppuccin Overlay1 - inactive workspaces
    export COLOR_ACTIVE_TEXT=0xff1e1e2e  # Dark text on accent background
    ;;
  
  "gruvbox")
    export BAR_COLOR=0xff282828
    export ITEM_BG_COLOR=0xff3c3836
    export ACCENT_COLOR=0xffd79921      # Gruvbox Yellow
    export FG_COLOR=0xffebdbb2
    export FG_MUTED=0xffa89984
    export FG_STRONG=0xfffbf1c7
    export WARN_COLOR=0xffcc241d
    
    # UI Hierarchy Colors
    export COLOR_PRIMARY=0xffffffff      # Pure white - time/date (anchor)
    export COLOR_SECONDARY=0xffebdbb2    # Gruvbox Light - CPU/RAM/Vol/Kb
    export COLOR_INACTIVE=0xffa89984     # Gruvbox Gray - inactive workspaces
    export COLOR_ACTIVE_TEXT=0xff282828  # Dark text on accent background
    ;;
  
  *)
    # Fallback to gray theme
    export BAR_COLOR=0xff101314
    export ITEM_BG_COLOR=0xff353c3f
    export ACCENT_COLOR=0xffffffff
    export FG_COLOR=0xffffffff
    export FG_MUTED=0xccffffff
    export FG_STRONG=0xffffffff
    export WARN_COLOR=0xffff4d4d
    ;;
esac

# Common colors
export WHITE=0xffffffff
export BLACK=0xff000000

# Function to switch themes (for future use)
switch_theme() {
  local new_theme="$1"
  sed -i '' "s/CURRENT_THEME=.*/CURRENT_THEME=\"$new_theme\"/" "$CONFIG_DIR/colors.sh"
  sketchybar --reload
}
