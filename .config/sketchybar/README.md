# SketchyBar Configuration - Refactored

This is a streamlined and simplified SketchyBar configuration that reduces complexity while maintaining full functionality.

## What Changed

### 🎯 **Before vs After File Count**
- **Before**: 19+ files scattered across multiple directories
- **After**: 7 core files with clear responsibilities

### 📁 **New Structure**
```
sketchybar/
├── sketchybarrc.new          # Main configuration (streamlined)
├── colors.new.sh             # Theme-based color management
├── helpers.sh                # Utility functions
├── items/
│   ├── spaces.new.sh         # Unified spaces component
│   └── front_app.new.sh      # Unified front app component
└── plugins/
    └── system_monitor.sh     # Consolidated system monitoring
```

## Key Improvements

### ✨ **1. Consolidated Configuration**
- **Single defaults block** instead of duplicated configurations
- **Bash arrays** for cleaner command batching
- **Inline simple items** to reduce file count

### 🎨 **2. Simplified Color Management**
- Easy theme switching via single variable
- Clean theme definitions
- Built-in theme switching function

### 🔧 **3. Unified Components**
- Complex items (spaces, front_app) now contain both definition and logic
- Reduced separation between item definition and plugin scripts
- Self-contained functionality

### 📊 **4. Consolidated System Monitoring**
- All system monitors (CPU, memory, battery, volume, etc.) in one file
- Reduced plugin file count from 10+ to 1
- Easier maintenance and debugging

### 🛠️ **5. Helper Utilities**
- Theme switching: `./helpers.sh switch-theme teal`
- Configuration reload: `./helpers.sh reload`
- Status checking: `./helpers.sh status`
- Debugging tools: `./helpers.sh query cpu`

## Quick Migration Guide

### 1. **Backup Current Configuration**
```bash
cp -r ~/.config/sketchybar ~/.config/sketchybar.backup
```

### 2. **Apply New Configuration**
```bash
# Replace main files
mv sketchybarrc.new sketchybarrc
mv colors.new.sh colors.sh
mv items/spaces.new.sh items/spaces.sh
mv items/front_app.new.sh items/front_app.sh

# Make scripts executable
chmod +x helpers.sh
chmod +x plugins/system_monitor.sh
chmod +x items/spaces.sh
chmod +x items/front_app.sh
```

### 3. **Test Configuration**
```bash
# Check if SketchyBar can load the config
sketchybar --reload

# Or restart completely
./helpers.sh restart
```

## Usage Examples

### **Theme Switching**
```bash
# Switch to different themes
./helpers.sh switch-theme teal
./helpers.sh switch-theme purple
./helpers.sh switch-theme blue
./helpers.sh switch-theme gray
```

### **Configuration Management**
```bash
# Reload configuration
./helpers.sh reload

# Check status
./helpers.sh status

# Restart SketchyBar
./helpers.sh restart
```

### **Debugging**
```bash
# Show current colors
./helpers.sh colors

# List all items
./helpers.sh items

# Query specific item
./helpers.sh query cpu
```

## Configuration Details

### **Bar Configuration**
Uses bash arrays for cleaner configuration:
```bash
bar_config=(
  position=bottom
  height=32
  blur_radius=20
  sticky=on
  padding_left=10
  padding_right=10
  color=$BAR_COLOR
)
```

### **Default Properties**
Single consolidated defaults block:
```bash
default_config=(
  padding_left=5
  padding_right=5
  icon.font="SF Pro:SemiBold:12.0"
  # ... other properties
)
```

### **Inline Simple Items**
Simple items defined directly in main config:
```bash
sketchybar --add item volume right \
           --set volume script="$PLUGIN_DIR/system_monitor.sh volume" \
           --subscribe volume volume_change
```

## Themes

### Available Themes:
- **gray** (default) - Clean gray theme
- **teal** - Ocean teal theme  
- **purple** - Modern purple theme
- **blue** - Classic blue theme

### Adding Custom Themes:
Edit `colors.sh` and add a new case to the theme switch:
```bash
"my_theme")
  export BAR_COLOR=0xff123456
  export ITEM_BG_COLOR=0xff789abc
  export ACCENT_COLOR=0xffdef012
  # ... other colors
  ;;
```

## Troubleshooting

### **Configuration Won't Load**
```bash
# Check syntax
bash -n sketchybarrc

# Check if SketchyBar is running
./helpers.sh status

# Restart with verbose output
killall sketchybar
sketchybar --config ~/.config/sketchybar/sketchybarrc
```

### **Items Not Updating**
```bash
# Force update all items
sketchybar --update

# Check specific item
./helpers.sh query item_name

# Restart SketchyBar
./helpers.sh restart
```

### **Reverting Changes**
```bash
# Restore backup
rm -rf ~/.config/sketchybar
mv ~/.config/sketchybar.backup ~/.config/sketchybar
sketchybar --reload
```

## Benefits of This Refactor

1. **Reduced Complexity**: 19+ files → 7 core files
2. **Easier Maintenance**: Unified components, consolidated plugins
3. **Better Organization**: Clear separation of concerns
4. **Enhanced Functionality**: Built-in theme switching and utilities
5. **Improved Performance**: Batch operations, optimized commands
6. **Better Documentation**: Self-documenting structure

## Files You Can Remove After Migration

Once you've confirmed the new configuration works:
```bash
# Old individual plugin files (replaced by system_monitor.sh)
rm plugins/cpu.sh plugins/memory.sh plugins/battery.sh 
rm plugins/volume.sh plugins/calendar.sh plugins/keyboard.sh

# Old individual item files (consolidated or replaced)
rm items/cpu.sh items/memory.sh items/battery.sh
rm items/volume.sh items/calendar.sh items/keyboard.sh

# Old color schemes (replaced by unified colors.sh)
rm colors-*.sh

# Old icon mapping (integrated into front_app.sh)
rm plugins/icon_map_fn.sh

# Backup files
rm -rf ~/.config/sketchybar.backup  # When you're confident it works
```

This refactored configuration maintains all your original functionality while being much easier to understand, maintain, and extend!
