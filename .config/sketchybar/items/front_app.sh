#!/bin/bash

# ==== SketchyBar Front App Component ====
# Unified component with definition and update logic

source "$CONFIG_DIR/colors.sh"

# ==== FRONT APP ITEM DEFINITION ====
# sketchybar --add item front_app left \
#            --set front_app background.color=$ACCENT_COLOR \
#                            icon.color=$BAR_COLOR \
#                            icon.font="sketchybar-app-font:Regular:16.0" \
#                            label.color=$BAR_COLOR \
#                            script="$CONFIG_DIR/items/front_app.sh update" \
#            --subscribe front_app front_app_switched

# ==== ICON MAPPING FUNCTION ====
# Simplified version with most common apps
get_app_icon() {
  local app="$1"

  case "$app" in
    "Alacritty"|"Ghostty"|"Hyper"|"iTerm2"|"kitty"|"Terminal"|"WezTerm")
      echo ":terminal:"
      ;;
    "Code"|"Code - Insiders")
      echo ":code:"
      ;;
    "Codex")
      echo ":codex:"
      ;;
    "Chromium"|"Google Chrome"|"Google Chrome Canary")
      echo ":google_chrome:"
      ;;
    "Firefox")
      echo ":firefox:"
      ;;
    "Preview")
      echo ":preview:"
      ;;
    "Finder")
      echo ":finder:"
      ;;
    "Slack")
      echo ":slack:"
      ;;
    "Spotify")
      echo ":spotify:"
      ;;
    "Discord"|"Discord Canary"|"Discord PTB")
      echo ":discord:"
      ;;
    "Telegram")
      echo ":telegram:"
      ;;
    "1Password")
      echo ":one_password:"
      ;;
    "Figma")
      echo ":figma:"
      ;;
    "Notion")
      echo ":notion:"
      ;;
    "Notes")
      echo ":notes:"
      ;;
    "Reminders")
      echo ":reminders:"
      ;;
    "Neovide"|"MacVim"|"Vim"|"VimR")
      echo ":vim:"
      ;;
    "Session")
      echo ":session:"
      ;;
    "OpenVPN Connect")
      echo ":openvpn_connect:"
      ;;
    "cmux")
      echo ":ghostty:"
      ;;
    "Caido")
      echo ":battle_net:"
      ;;
    *)
      echo ":default:"
      ;;
  esac
}

# ==== UPDATE LOGIC ====
update_front_app() {
  if [ "$SENDER" = "front_app_switched" ]; then
    local app_name="$INFO"
    local app_icon=$(get_app_icon "$app_name")

    sketchybar --set "$NAME" \
               label="$app_name" \
               icon="$app_icon"
  fi
}

# ==== MAIN EXECUTION LOGIC ====
case "$1" in
  "update")
    update_front_app
    ;;
  *)
    # Default: just define the item (this happens when sourced from main config)
    ;;
esac
