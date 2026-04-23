# nvm default node version (for non-interactive shells like IDE agents)
export NVM_DIR="$HOME/.config/nvm"
if [ -s "$NVM_DIR/alias/default" ]; then
  DEFAULT_NODE_VERSION=$(cat "$NVM_DIR/alias/default")
  if [ "$DEFAULT_NODE_VERSION" = "node" ]; then
    DEFAULT_NODE_VERSION="v24.4.1"  # or your preferred version
  fi
  export PATH="$NVM_DIR/versions/node/$DEFAULT_NODE_VERSION/bin:$PATH"
fi

export PATH="/opt/homebrew/opt/curl/bin/:$PATH:$HOME/go/bin/:$HOME/.bin:$HOME/bin:$HOME/.config/rofi/scripts:$HOME/.local/bin:/usr/local/bin:$HOME/.local/kitty.app/bin:$HOME/bin:/usr/local/go/bin:$HOME/bin/:/usr/local/opt/openvpn/sbin/:$ANDROID_HOME/build-tools/36.1.0/:/opt/local/bin:$HOME/.cargo/bin:$HOME/.dotnet/tools"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export TERM="xterm-256color"
export EDITOR="vim"
# export BROWSER="/Applications/Arc.app/Contents/MacOS/Arc"
export SSH_KEY_PATH="~/.ssh/dsa_id"
export _JAVA_AWT_WM_NONREPARENTING=1
export JAVA_HOME="$(/usr/libexec/java_home -v 21)"
export PIPX_HOME="$HOME/.local/pipx"

export JQ_COLORS="0;37:0;37:0;37:0;32:0;32:0;37:0;33"

# export UV_PYTHON=3.12

# Command history
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# XDG DIRECTORIES
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_STATE_HOME="$HOME/.local/state"

# xdg-ninja
# export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql_history
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
# export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
# export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
# export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export CALCHISTFILE="$XDG_CACHE_HOME"/calc_history
# export XAUTHORITY="$XDG_RUNTIME_DIR"/authority

# pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init --path)"

# color scheme
LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=01;36;40:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

