# TODO: https://dougblack.io/words/zsh-vi-mode.html

# Loaded emacs-style bindings first, in order to prevent
# clobbering new zit/zim bindings
bindkey -e

## Load zit (plugin manager)
# Based on zsh version, zit sets up zim or falls back
source "${HOME}/.zitrc"

# Set distribution-specific things (ZSH, PATH, BROWSER, TERM, ...)
# dotty takes care of the initial setup -- only sync the file to home
# for a given distribution

# Local zshrc, whatever it is
[ -f ~/.zshrc_local ] && source ~/.zshrc_local
[ -f ~/.zshrc_system ] && source ~/.zshrc_system
[ -f ~/.zshrc_machine ] && source ~/.zshrc_machine

# enable zmv
autoload -U zmv
alias zmv="noglob zmv -W"

## Editing ZLE bindings
# Edit the ls command binding to instead use ls -lFh
#bindkey -r '\el'
bindkey -s '\el' 'ls -lAFh\n'
bindkey -s '\es' 'git status\n'
bindkey -s '\ed' 'git diff\n'

# Enable editing complex commands (or use `fc`)
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
#bindkey -M vicmd v edit-command-line

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# try to cd if the command is not found
setopt auto_cd
# share commands between sessions
setopt share_history 
setopt hist_expire_dups_first
setopt nobeep

# Hook direnv
eval "$(direnv hook zsh)"

# Hook autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# Hook grc (colorify standard commands)
# unalias grc
# [ -f /usr/local/etc/grc.zsh ] && . /usr/local/etc/grc.zsh
# Colorize LS
LS_COLORS=$LS_COLORS:'di=0;35:' ; export LS_COLORS

## General aliasess
[[ `type -w ag` =~ "alias$" ]] && unalias ag # ubuntu plugin enables it, zshrc_local loads too early to overrule
alias jn='jupyter notebook'
alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc && source ~/.zshrc'
alias aG='alias G'
alias go='googler'

# Homebrew aliases
alias b='brew'
alias bi='brew install'
alias bu='brew uninstall'
alias bf='brew info'
alias bs='brew search'
alias buu='brew update && brew upgrade'
alias bci='brew cask install'
alias bcu='brew cask uninstall'
alias bcf='brew cask info'
alias bcs='brew cask search'

alias bl='brew leaves'
alias bcl='brew cask list'

alias k='k -h'
alias ka='k -Ah'
alias ls='ls -GFh'

# Commonly used aliases from oh-my-zsh/common-aliases
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"

# Commonly used aliases from oh-my-zsh/git
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcam='git commit -a -m'

alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gcmsg='git commit -m'

alias gd='git diff'
alias gdc='git diff --cached'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdw='git diff --word-diff'

alias glg='git log --stat'
alias glga='git log --oneline --decorate --graph --all'

alias grbm='git rebase master'

alias grhh='git reset HEAD --hard'
alias gru='git reset --'

alias gsb='git status -sb'
alias gst='git status'

alias stash='git stash'
alias unstash='git stash pop'

alias glum='git pull upstream master'

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

# Run jupyter notebook in Docker with PWD as mounted volume
jnd() {
  # TODO: Find available port (cycle through `lsof -i tcp:$PORT` until output empty / non-zero exit status?)
  # https://stackoverflow.com/questions/6942097/finding-next-open-port
  # https://unix.stackexchange.com/questions/55913/whats-the-easiest-way-to-find-an-unused-local-port
  # TODO: Launch localhost:$PORT upon successful completion?
  # TODO: Voluntary argument for name, otherwise omit the `--name` argument?
  # (Argument for status quo: this forces exactly one instance of jupyter notebook)
  # (Related: should we try to stop & rm the previous instance?)
  # TODO: Just pass through all arguments?
  docker run -d --name jn -v $(pwd -P):/home/jovyan/work -p 8888:8888 jupyter/datascience-notebook start-notebook.sh --NotebookApp.token=''
}

## Final commands
# autorun tmux if it (1) is not running yet, (2) exists, (3) this session isn't running in ssh
# if [ "$TMUX" = "" ] && [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ] && [ "$ITERM_PROFILE" != "Hotkey Window" ]; then
#   # always attach to 'main' or create it
#   command -v tmux >/dev/null 2>&1 && tmux new -A -s "home";
# fi
# Commented out in favor of executing this for iTerm default session

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
