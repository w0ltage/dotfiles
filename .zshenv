# Shell settings
export PATH="$PATH:$HOME/go/bin/:$HOME/.bin:$HOME/.config/rofi/scripts:$HOME/.local/bin:/usr/local/bin:$HOME/.local/kitty.app/bin"
export TERM="xterm-256color"
export EDITOR="vim"
export BROWSER="firefox"
export SSH_KEY_PATH="~/.ssh/dsa_id"
export _JAVA_AWT_WM_NONREPARENTING=1

# Command history
export HISTFILE="$HOME/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

# XDG DIRECTORIES
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_STATE_HOME="$HOME/.local/state"

# xdg-ninja
export ANDROID_HOME="$XDG_DATA_HOME"/android
# export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
# export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
# export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export CALCHISTFILE="$XDG_CACHE_HOME"/calc_history
# export XAUTHORITY="$XDG_RUNTIME_DIR"/authority
export LIBVIRT_DEFAULT_URI="qemu:///system"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
