# export SSLKEYLOGFILE=~/.ssl-key.log

# Add deno completions to search path
if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then export FPATH="$HOME/.zsh/completions:$FPATH"; fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# include aliases from .alias_zsh and env variables from .zshenv
[[ -f $HOME/.alias_zsh ]] && . $HOME/.alias_zsh
[[ -f $HOME/.zshenv ]] && . $HOME/.zshenv
[[ -f $HOME/.env ]] && . $HOME/.env

# ohmyzsh
ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
# ZSH_THEME="afowler"
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_UPDATE="true"
plugins=(
#	git
    )
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
[[ ! -d $ZSH_CACHE_DIR ]] && mkdir -p $ZSH_CACHE_DIR
ZSH_DISABLE_COMPFIX=true  # Skip compaudit for faster startup
source $ZSH/oh-my-zsh.sh

# zinit (zsh plugin manager) Initialization
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# zinit plugins load with turbo mode (load after prompt)
zinit ice wait lucid
zinit light z-shell/F-Sy-H                 # syntax highlight

zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions  # autosuggestions

# nvm lazy loading via zsh-nvm plugin
export NVM_DIR="$HOME/.config/nvm"
export NVM_LAZY_LOAD=true
zinit ice wait lucid
zinit light lukechilds/zsh-nvm

# iterm2 integration check
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

# fzf & fd
# [[ -e "/usr/share/fzf/fzf-extras.zsh" ]] && source /usr/share/fzf/fzf-extras.zsh
# export FZF_DEFAULT_COMMAND="fd --type file --color=always --follow --hidden --exclude .git"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# # export FZF_DEFAULT_OPTS="--ansi"
# export FZF_DEFAULT_OPTS="--height 50% --layout=reverse --border --preview 'file {}' --preview-window down:1"
# export FZF_COMPLETION_TRIGGER="~~"

# nvm (node version manager) initialization
# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# zoxide lazy loading (renamed to 'j')
if command -v zoxide >/dev/null 2>&1; then
  
  # The loader function
  _zoxide_init() {
    # 1. Remove the wrappers first so they don't block the real definitions
    unfunction j ji
    
    # 2. Initialize zoxide (which defines 'j' and 'ji' functions)
    eval "$(zoxide init zsh --cmd j)"
  }

  # Wrapper for 'j'
  j() {
    _zoxide_init    # Swap the wrapper for the real thing
    j "$@"          # Run the new 'j' function
  }

  # Wrapper for 'ji'
  ji() {
    _zoxide_init    # Swap the wrapper for the real thing
    ji "$@"         # Run the new 'ji' function
  }
fi


# ADDS 0.29s to load zsh
# # The next line updates PATH for Yandex Cloud CLI.
# if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi

# # The next line enables shell command completion for yc.
# if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi


# pnpm
export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ 1 -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
# unset __conda_setup
# <<< conda initialize <<<

# uv lazy loading
if command -v uv >/dev/null 2>&1; then
  _uv_init() {
    eval "$(command uv generate-shell-completion zsh)"
    unfunction _uv_init
    unfunction uv
  }
  # Wrap uv command to initialize completions on first use
  uv() {
    _uv_init
    command uv "$@"
  }
fi

# Task Master aliases added on 6/22/2025
alias tm='task-master'
alias taskmaster='task-master'

fpath+=~/.zfunc

# Optimize compinit by skipping check if dump is less than 24h old
autoload -Uz compinit
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' menu select
export PATH="$HOME/osmedeus-base/binaries:$PATH"

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# Osmedeus CLI
export PATH="$HOME/.local/bin:$PATH"

# Added by osmedeus
export PATH="$HOME/osmedeus-base/external-binaries:$PATH"

# strix
export PATH="$HOME/.strix/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"

# disable bell
setopt NO_BEEP

# claude
export CLAUDE_CODE_NO_FLICKER=1
