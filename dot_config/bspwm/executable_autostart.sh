#! /bin/sh

# run command only if it's not already running on the system
run() { 
  # if a process is already running, then `pgrep` will return failure 
  # instead of success because of "!"
  # then "$@" will run passed arguments (command), if `pgrep` return success
  ! pgrep -x "$1" >/dev/null && "$@"; 
}

# almost the same as previous function
# but this time it uses -f to search for the process by its full name
frun() { 
  ! pgrep -f "$1" >/dev/null && "$@"; 
}

# sets the root window (main background) of the X Window System display 
# to use the "left_ptr" cursor, which is the default cursor that looks 
# like an arrow pointing to the left. you can change it 
# to an arrow pointing to the right with name "right_ptr"
xsetroot -cursor_name left_ptr &

# sets us/ru layouts with the option to switch layouts via ALT + SHIFT
# and enable "scroll lock" indicator on the keyboard to identify language switch
setxkbmap -layout us,ru -option "grp:alt_shift_toggle,grp_led:scroll" &

# start and daemonize picom with custom config 
picom -b --config $HOME/.config/picom/picom.conf &

# run nitrogen if not running and restore saved background
# run nitrogen --restore &

# run sxhkd (hotkey daemon) if not running with custom config
run sxhkd -c $HOME/.config/bspwm/sxhkd/sxhkdrc &

# checks if polybar installed
if [ "$(which polybar)" != "polybar not found" ]; then
  # starts polybar
  sh -c "$HOME/.config/polybar/launch.sh &"
fi

# system tray
run tint2 -c $HOME/.config/tint2/tray.tint2rc &

# customizable notification daemon
run dunst &

# checks if thunar is installed
if [ "$(which thunar)" != "thunar not found" ]; then
  # daemonize Thunar for a faster startup of Thunar;
  # Thunar running in the background and only opening a window when necessary 
  # (for instance, when a flash drive is inserted);
  # letting Thunar handle automatic mounting of removable media
  thunar --daemon &
fi

# daemon for settings to Xorg applications
xsettingsd &

# an authentication agent is used to make the user of a session prove 
# that they really are the user 
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# keyring is "a collection of components in GNOME that store secrets, 
# passwords, keys, certificates and make them available to applications."
# gnome-keyring-daemon --start --components=pkcs11 &

# blue light filter moved to crontab
# frun blugon & 

# hides your X mouse cursor when you do not need it
run unclutter &


### SYSTEM TRAY APPLETS
# system tray applet for NetworkManager
run nm-tray &

# power manager system tray applet + power manager itself
run xfce4-power-manager &

# clipboard manager
run parcellite &

# automounter for removable media
run udiskie -t &

# daemon to fix scrolling in logitech mouse
# run solaar -w hide &

# auto-resize windows of vm
run $HOME/.config/bspwm/scripts/resolution.sh &
