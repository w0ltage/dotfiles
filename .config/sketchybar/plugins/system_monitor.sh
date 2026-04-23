#!/bin/bash

# ==== SketchyBar System Monitor Plugins ====
# Consolidated CPU, Memory, and Battery monitoring

# ==== CPU MONITORING ====
update_cpu() {
  local core_count=$(sysctl -n machdep.cpu.thread_count)
  local cpu_info=$(ps -eo pcpu,user)
  local cpu_sys=$(echo "$cpu_info" | grep -v "$(whoami)" | sed "s/[^ 0-9\\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $core_count)}")
  local cpu_user=$(echo "$cpu_info" | grep "$(whoami)" | sed "s/[^ 0-9\\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $core_count)}")
  
  local cpu_percent=$(echo "$cpu_sys $cpu_user" | awk '{printf "%.0f\n", ($1 + $2)*100}')
  
  sketchybar --set cpu label="${cpu_percent}%"
}

# ==== MEMORY MONITORING ====
update_memory() {
  local ram_percent=$(vm_stat | grep "Pages active" | awk '{print $3}' | tr -d '.' | awk -v total="$(sysctl -n hw.memsize)" '{printf "%.0f\n", ($1 * 4096) / total * 100}')
  
  sketchybar --set memory label="${ram_percent}%"
}

# ==== VOLUME MONITORING ====
update_volume() {
  if [ "$SENDER" = "volume_change" ]; then
    local volume="$INFO"
    local icon
    
    case "$volume" in
      [6-9][0-9]|100) icon="􀊩" ;;
      [3-5][0-9]) icon="􀊥" ;;
      [1-9]|[1-2][0-9]) icon="􀊡" ;;
      *) icon="􀊣" ;;
    esac
    
    sketchybar --set volume icon="$icon" label="${volume}%"
  fi
}

# ==== CALENDAR ====
update_calendar() {
  sketchybar --set calendar label="$(date +'%d %m %a | %I:%M %p')"
}

# ==== KEYBOARD LAYOUT ====
update_keyboard() {
  local layout=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep -o '"KeyboardLayout Name" = [^;]*' | sed 's/"KeyboardLayout Name" = //')
  
  # Convert layout names to clear text abbreviations
  case "$layout" in
    "U.S."|"ABC"|"") layout="US" ;;
    "Russian"|"RU") layout="RU" ;;
    "German"|"DE") layout="DE" ;;
    "French"|"FR") layout="FR" ;;
    "Spanish"|"ES") layout="ES" ;;
    "Italian"|"IT") layout="IT" ;;
    "Portuguese"|"PT") layout="PT" ;;
    "Dutch"|"NL") layout="NL" ;;
    *) layout="${layout:0:2}" ;;
  esac
  
  sketchybar --set keyboard label="$layout"
}

# ==== MAIN EXECUTION ====
case "$1" in
  "cpu") update_cpu ;;
  "memory") update_memory ;;
  "battery") update_battery ;;
  "volume") update_volume ;;
  "calendar") update_calendar ;;
  "keyboard") update_keyboard ;;
  *) 
    echo "Usage: $0 {cpu|memory|battery|volume|calendar|keyboard}"
    exit 1
    ;;
esac
