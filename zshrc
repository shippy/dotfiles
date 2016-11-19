# Set distribution-specific things (ZSH, PATH, BROWSER, TERM, ...)
# dotty takes care of the initial setup -- only sync the file to home
# for a given distribution

plugins=(git mercurial git-extras github sudo tmux pip common-aliases command-not-found python autojump cp ssh-agent heroku fancy-ctrl-z) 
# git_remote_branch history jsontools last-working-dir per-directory-history wd
# zsh-history-substring-search? thefuck rather than sudo? zsh-navigation-tools?

# Local zshrc, whatever it is
# NB: It needs to define the location of oh-my-zsh in $ZSH
[ -f ~/.zshrc_local ] && source ~/.zshrc_local

# Set name of the oh-my-zsh theme to load.
ZSH_THEME="terminalparty" # terminalparty; kardan, if more customized; agnoster; juanghartado

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# enable command auto-correction.
ENABLE_CORRECTION="true"

# automatically update without prompting (DISABLE_AUTO_UPDATE for neither)
DISABLE_UPDATE_PROMPT="true"

source $ZSH/oh-my-zsh.sh

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
  ls -lFh
}

## General aliasess
alias jn='jupyter notebook'
alias sz='source ~/.zshrc'
alias ez='vim ~/.zshrc'

## Final commands
# autorun tmux if it (1) is not running yet, (2) exists, (3) this session isn't running in ssh
if [ "$TMUX" = "" ] && [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then 
  command -v tmux >/dev/null 2>&1 && tmux;
fi
