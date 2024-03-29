#!/usr/bin/sh

# Command history
export HISTSIZE=10000
export SAVEHIST=10000

# initialize X session
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# include aliases from .alias_zsh and env variables from .zshenv
[[ -f $HOME/.alias_zsh ]] && . ~/.alias_zsh
[[ -f $HOME/.zshenv ]] && . $HOME/.zshenv

# ohmyzsh
ZSH="$HOME/.config/oh-my-zsh"
ZSH_CUSTOM="$HOME/.config/oh-my-zsh/custom"
ZSH_THEME="smoothmonkey"
DISABLE_AUTO_UPDATE="true"
plugins=(
    fast-syntax-highlighting
    zsh-autosuggestions
    )
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
[[ ! -d $ZSH_CACHE_DIR ]] && mkdir -p $ZSH_CACHE_DIR
source $ZSH/oh-my-zsh.sh
# source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf & fd
[[ -e "/usr/share/fzf/fzf-extras.zsh" ]] && source /usr/share/fzf/fzf-extras.zsh
export FZF_DEFAULT_COMMAND="fd --type file --color=always --follow --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_DEFAULT_OPTS="--ansi"
export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --preview 'file {}' --preview-window down:1"
export FZF_COMPLETION_TRIGGER="~~"

# zprof
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
