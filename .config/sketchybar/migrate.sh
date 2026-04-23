#!/bin/bash

# ==== SketchyBar Configuration Migration Script ====
# This script helps migrate from the old configuration to the refactored one

set -e  # Exit on any error

SKETCHYBAR_DIR="$HOME/.config/sketchybar"
BACKUP_DIR="$HOME/.config/sketchybar.backup.$(date +%Y%m%d_%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "sketchybarrc" ]; then
    print_error "Please run this script from your SketchyBar configuration directory"
    print_error "Expected: $SKETCHYBAR_DIR"
    exit 1
fi

print_step "Starting SketchyBar configuration migration..."

# Step 1: Create backup
print_step "Creating backup of current configuration..."
if [ -d "$BACKUP_DIR" ]; then
    print_warning "Backup directory already exists: $BACKUP_DIR"
else
    cp -r "$SKETCHYBAR_DIR" "$BACKUP_DIR"
    print_success "Backup created: $BACKUP_DIR"
fi

# Step 2: Check for new files
required_files=(
    "sketchybarrc.new"
    "colors.new.sh"
    "helpers.sh"
    "items/spaces.new.sh"
    "items/front_app.new.sh"
    "plugins/system_monitor.sh"
)

missing_files=()
for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        missing_files+=("$file")
    fi
done

if [ ${#missing_files[@]} -ne 0 ]; then
    print_error "Missing required files for migration:"
    for file in "${missing_files[@]}"; do
        echo "  - $file"
    done
    print_error "Please ensure all refactored files are present before running migration."
    exit 1
fi

# Step 3: Stop SketchyBar
print_step "Stopping SketchyBar..."
if pgrep -x "sketchybar" > /dev/null; then
    killall sketchybar
    sleep 1
    print_success "SketchyBar stopped"
else
    print_warning "SketchyBar was not running"
fi

# Step 4: Apply new configuration
print_step "Applying new configuration files..."

# Replace main files
mv sketchybarrc.new sketchybarrc
mv colors.new.sh colors.sh

# Replace item files
mv items/spaces.new.sh items/spaces.sh
mv items/front_app.new.sh items/front_app.sh

print_success "Configuration files replaced"

# Step 5: Set permissions
print_step "Setting proper permissions..."
chmod +x helpers.sh
chmod +x plugins/system_monitor.sh
chmod +x items/spaces.sh
chmod +x items/front_app.sh
print_success "Permissions set"

# Step 6: Validate configuration
print_step "Validating new configuration..."
if bash -n sketchybarrc; then
    print_success "Configuration syntax is valid"
else
    print_error "Configuration syntax error detected"
    print_error "Restoring backup..."
    rm -rf "$SKETCHYBAR_DIR"
    mv "$BACKUP_DIR" "$SKETCHYBAR_DIR"
    print_error "Migration failed. Original configuration restored."
    exit 1
fi

# Step 7: Start SketchyBar with new configuration
print_step "Starting SketchyBar with new configuration..."
sketchybar &
sleep 2

if pgrep -x "sketchybar" > /dev/null; then
    print_success "SketchyBar started successfully"
else
    print_error "Failed to start SketchyBar"
    print_error "Check the logs with: tail -f /var/log/system.log | grep sketchybar"
    exit 1
fi

# Step 8: Cleanup old files (optional)
print_step "Identifying old files that can be removed..."

old_files=(
    "plugins/cpu.sh"
    "plugins/memory.sh"  
    "plugins/battery.sh"
    "plugins/volume.sh"
    "plugins/calendar.sh"
    "plugins/keyboard.sh"
    "plugins/space.sh"
    "plugins/space_windows.sh"
    "plugins/front_app.sh"
    "plugins/icon_map_fn.sh"
    "items/cpu.sh"
    "items/memory.sh"
    "items/battery.sh"
    "items/volume.sh"
    "items/calendar.sh"
    "items/keyboard.sh"
    "colors-catpuccin-mocha.sh"
    "colors-gruvbox.sh"
)

existing_old_files=()
for file in "${old_files[@]}"; do
    if [ -f "$file" ]; then
        existing_old_files+=("$file")
    fi
done

if [ ${#existing_old_files[@]} -gt 0 ]; then
    echo
    print_warning "The following old files can now be removed:"
    for file in "${existing_old_files[@]}"; do
        echo "  - $file"
    done
    echo
    read -p "Would you like to remove these old files now? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        for file in "${existing_old_files[@]}"; do
            rm -f "$file"
            echo "  Removed: $file"
        done
        print_success "Old files removed"
    else
        print_warning "Old files kept. You can remove them manually later."
    fi
fi

# Final summary
echo
echo "============================================"
print_success "Migration completed successfully!"
echo "============================================"
echo
echo "New structure summary:"
echo "  📄 Main config:     sketchybarrc (streamlined)"
echo "  🎨 Colors:          colors.sh (theme-based)"
echo "  🛠️  Utilities:       helpers.sh"
echo "  📁 Complex items:   items/{spaces,front_app}.sh"
echo "  📊 System monitor:  plugins/system_monitor.sh"
echo
echo "Try these new features:"
echo "  🎨 Switch theme:    ./helpers.sh switch-theme teal"
echo "  🔄 Reload config:   ./helpers.sh reload"
echo "  📊 Check status:    ./helpers.sh status"
echo "  🔍 Debug items:     ./helpers.sh query cpu"
echo
echo "Backup location: $BACKUP_DIR"
print_warning "Keep the backup until you're confident the new configuration works!"
echo
print_success "Enjoy your simplified SketchyBar configuration! 🎉"
