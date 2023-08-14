# modified smoothmonkey.zsh-theme
# original theme: https://github.com/sebastianpulido/oh-my-zsh/smoothmonkey.zsh-theme
# that based on: https://github.com/andyfleming/oh-my-zsh/blob/master/themes/af-magic.zsh-theme
# which based on: jbergantine.zsh-theme

# print new line after prompt
precmd() {
    precmd() {
        print ""
    }
}

# settings
typeset +H return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
typeset +H my_gray="$FG[237]"
typeset +H my_orange="$FG[214]"

# primary prompt
# with hostname
# PS1='%m %B%F{blue}:: %{$fg_bold[green]%}%2d $(git_prompt_info)%{$fg_bold[cyan]%} 

# without hostname
PS1='%{$fg_bold[green]%}%2d $(git_prompt_info)%{$fg_bold[cyan]%} 
> %{$reset_color%}'

PS2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'

# right prompt
(( $+functions[virtualenv_prompt_info] )) && RPS1+='$(virtualenv_prompt_info)'
# RPS1+=' $my_gray%n@%m%{$reset_color%}%'

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[white]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[white]%})"

# hg settings
ZSH_THEME_HG_PROMPT_PREFIX="$FG[075]($FG[078]"
ZSH_THEME_HG_PROMPT_CLEAN=""
ZSH_THEME_HG_PROMPT_DIRTY="$my_orange*%{$reset_color%}"
ZSH_THEME_HG_PROMPT_SUFFIX="$FG[075])%{$reset_color%}"

# virtualenv settings
ZSH_THEME_VIRTUALENV_PREFIX=" $FG[075]["
ZSH_THEME_VIRTUALENV_SUFFIX="]%{$reset_color%}"
