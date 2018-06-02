# TODO: https://dougblack.io/words/zsh-vi-mode.html

# Loaded emacs-style bindings first, in order to prevent
# clobbering new zit/zim bindings
bindkey -e

## Load zit (plugin manager)
# Based on zsh version, zit sets up zim or falls back
source "${HOME}/.zitrc"
[ ! -z "$ADOTDIR" ] && antigen init ~/.antigenrc

# Set distribution-specific things (ZSH, PATH, BROWSER,
# TERM, ...). dotty takes care of the initial setup --
# only sync the file to home for a given distribution

# Local zshrc, whatever it is
[ -f ~/.zshrc_local ] && source ~/.zshrc_local
[ -f ~/.zshrc_system ] && source ~/.zshrc_system
[ -f ~/.zshrc_machine ] && source ~/.zshrc_machine

# enable zmv
autoload -U zmv
alias zmv="noglob zmv -W"

export LANG=en_US.UTF-8
export EDITOR='vim'

setopt auto_cd
setopt share_history
setopt hist_expire_dups_first
setopt nobeep

# Hook direnv
[[ `type direnv &> /dev/null` ]] && eval "$(direnv hook zsh)"

# Hook autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Colorize LS
LS_COLORS=$LS_COLORS:'di=0;35:'; export LS_COLORS
[ -z "$USER" ] && export USER=`whoami`

## General aliasess
# Load bash-compatible aliases from a shared file 
# (using compatibility mode)
source_sh () {
  emulate -LR sh
  . "$@"
}
if [ -f ~/dotfiles/shell/aliases.sh ]; then
  source_sh ~/dotfiles/shell/aliases.sh
fi
if [ -f ~/dotfiles/shell/aliases.zsh ]; then
  source ~/dotfiles/shell/aliases.zsh
fi

## Fancy Ctrl-Z (courtesy of Oh-my-zsh / Sheerun)
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

## FZF
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
# Blacklisted useless folders in .ignore

# Courtesy of junngunn & fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
alias v='fe'

# Taken from sodiumjoe/dotfiles
fbr() {
  local branches branch
  branches=$(git branch --format="%(refname:short)" --sort=-committerdate) &&
    branch=$(echo "$branches" | fzf) &&
    git checkout $branch
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
