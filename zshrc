# Set distribution-specific things (ZSH, PATH, BROWSER, TERM, ...)
# dotty takes care of the initial setup -- only sync the file to home
# for a given distribution
#
# TODO: Try zim [https://github.com/zimframework/zim]

plugins=(git sudo tmux pip common-aliases python autojump cp ssh-agent heroku fancy-ctrl-z)
# git_remote_branch history jsontools last-working-dir per-directory-history wd
# zsh-history-substring-search? thefuck rather than sudo? zsh-navigation-tools?

# Local zshrc, whatever it is
# NB: It needs to define the location of oh-my-zsh in $ZSH
[ -f ~/.zshrc_local ] && source ~/.zshrc_local
[ -f ~/.zshrc_system ] && source ~/.zshrc_system
[ -f ~/.zshrc_machine ] && source ~/.zshrc_machine

# Set name of the oh-my-zsh theme to load.
ZSH_THEME="terminalparty" # terminalparty; kardan, if more customized; agnoster; juanghartado

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# enable command auto-correction.
ENABLE_CORRECTION="true"

# automatically update without prompting (DISABLE_AUTO_UPDATE for neither)
DISABLE_UPDATE_PROMPT="true"

source $ZSH/oh-my-zsh.sh

# enable zmv
autoload -U zmv
alias zmv="noglob zmv -W"

## Editing oh-my-zsh ZLE bindings
# Unbind Ctrl+Left/Right (forward/backward-word in ZLE interferes with tmux)
bindkey -r '^[[C'
bindkey -r '^[[1;5C'
bindkey -r '^[[D'
bindkey -r '^[[1;5D'

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

setopt AUTO_CD

# Execute ls on every dir change
function chpwd() {
  emulate -L zsh
  detailedlslines=`ls -laFh | wc -l`
  summarylslines=`ls -C | wc -l`
  termlines=`expr $(tput lines) - 2`
  if [[ detailedlslines -ge termlines ]]; then
    if [[ summarylslines -ge termlines ]]; then
      CLICOLOR_FORCE=1 ls -a | head -n $termlines
      echo '\n(...)'
    else
      echo 'less'
      ls -a
    fi
  else
    ls -laFh
  fi
}

## General aliasess
[[ `type -w ag` =~ "alias$" ]] && unalias ag # ubuntu plugin enables it, zshrc_local loads too early to overrule
alias jn='jupyter notebook'
alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc && source ~/.zshrc'
alias aG='alias G'
alias go='googler'

# Homebrew aliases
function b() {
  exec brew "$@"
}
function bi() {
  exec brew install "$@"
}
function bu() {
  exec brew uninstall "$@"
}
function bf() {
  exec brew info "$@"
}
function bs() {
  exec brew search "$@"
}
function bci() {
  exec brew cask install "$@"
}
function bcu() {
  exec brew cask uninstall "$@"
}
function bcf() {
  exec brew cask info "$@"
}
function bcs() {
  exec brew cask search "$@"
}

alias bl='brew leaves'
alias bcl='brew cask list'
# Courtesy of junngunn & fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
alias v='fe'

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
if [ "$TMUX" = "" ] && [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ] && [ "$ITERM_PROFILE" != "Hotkey Window" ]; then
  # always attach to 'main' or create it
  command -v tmux >/dev/null 2>&1 && tmux new -A -s "home";
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
