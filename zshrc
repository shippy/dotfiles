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

# Make zsh ctrl-w act as it does in bash  - i.e. stop at special characters
tcsh-backward-delete-word () {
  # local WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
  local WORDCHARS="${WORDCHARS:s#-#}"
  local WORDCHARS="${WORDCHARS:s#/#}"
  zle backward-delete-word
}
zle -N tcsh-backward-delete-word tcsh-backward-delete-word
bindkey '^W' tcsh-backward-delete-word

setopt auto_cd
setopt share_history
setopt hist_expire_dups_first
setopt incappendhistory
setopt nobeep
# setopt correct

## From https://github.com/yous/vanilli.sh/blob/master/vanilli.zsh
# If a completion is performed with the cursor within a word, and a full
# # completion is inserted, the cursor is moved to the end of the word.
setopt always_to_end
# If unset, the cursor is set to the end of the word if completion is started.
# # Otherwise it stays there and completion is done from both ends.
setopt complete_in_word
unsetopt list_beep
unsetopt flow_control
zstyle ':completion:*' list-prompt   ''
zstyle ':completion:*' select-prompt ''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:default' menu yes select
# This seems to allow for cd /f/s/l/n to expand
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Z}{a-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# ...but, if it matches a directory, don't double-guess
zstyle ':completion:*' accept-exact-dirs true
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'
# zstyle ':completion:*:parameters'  list-colors '=*=32'
# zstyle ':completion:*:commands' list-colors '=*=1;31'
# zstyle ':completion:*:aliases' list-colors '=*=2;38;5;128'
# zstyle ':completion:*:options:*' list-colors '=(#b) #(--[a-z-]#)=34=36=33'
# zstyle ':completion:*:default' list-colors '=(#b)*(XX *)=32=31' '=*=32'
zstyle ':completion:*:descriptions' format "%B--- %d%b"
# Select an option immediately, even if the list is long
unsetopt listambiguous
setopt autolist
# Fixes the annoying Bash autocompletion issue where after TAB, line would reprint
setopt alwayslastprompt
setopt listpacked

# Autocomplete corrections
zstyle ':completion:*' completer _complete _approximate 
zstyle ':completion:*' group-order original corrections

autoload -Uz compinit
if [[ -n ${HOME}/.zcompdump(#qN.mh+24)  ]]; then
  compinit
  # and update timestamp
  compdump
else
  compinit -C
fi
compdef sshrc=ssh
# Without this, need to explicitly specify . if I want to autocomplete to a hidden file/dir
_comp_options+=(globdots)
# Use Shift-Tab
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete


setopt autopushd
setopt autocd
setopt chaselinks
setopt pushd_ignore_dups
setopt pushd_minus
unsetopt posixcd
DIRSTACKSIZE=10

if [ -z "$HISTFILE" ]; then
  export HISTFILE=~/.zhistory
  export HISTSIZE=50000
  export SAVEHIST=50000
fi

# Hook direnv
type direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

# Hook autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /usr/share/autojump/autojump.zsh ] && source /usr/share/autojump/autojump.zsh

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

## "Hold this command while I run this other one"
# Courtesy of: https://sgeb.io/posts/2016/11/til-bash-zsh-half-typed-commands/
# More on ZLE widgets: https://sgeb.io/posts/2014/04/zsh-zle-custom-widgets/
bindkey '^q' push-line-or-edit

## FZF
type ag >/dev/null 2>&1 && export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
# Blacklisted useless folders in .ignore

# Courtesy of junegunn & fzf
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

# added by pipsi (https://github.com/mitsuhiko/pipsi)
export PATH="/home/simon/.local/bin:$PATH"
