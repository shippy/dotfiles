# Set distribution-specific things (ZSH, PATH, BROWSER, TERM, ...)
# dotty takes care of the initial setup -- only sync the file to home
# for a given distribution
# NB: It needs to define the location of oh-my-zsh in $ZSH
[ -f ~/.zshrc_osx ] && source ~/.zshrc_osx
[ -f ~/.zshrc_crouton ] && source ~/.zshrc_crouton
[ -f ~/.zshrc_hpc ] && source ~/.zshrc_hpc
[ -f ~/zshrc_babun ] && source ~/zshrc_babun

# Set name of the oh-my-zsh theme to load.
ZSH_THEME="juanghurtado"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# enable command auto-correction.
ENABLE_CORRECTION="true"

source $ZSH/oh-my-zsh.sh

## Editing oh-my-zsh ZLE bindings
# Unbind Ctrl+Left/Right (forward/backward-word in ZLE interferes with tmux)
bindkey -r '^[[C'
bindkey -r '^[[1;5C'
bindkey -r '^[[D'
bindkey -r '^[[1;5D'

# Edit the ls command binding to instead use ls -lFh
#bindkey -r '\el'
bindkey -s '\el' 'ls -lFh\n'
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

## Final commands
# autorun tmux if it (1) is not running yet, (2) exists
if [ "$TMUX" = "" ]; then 
  command -v tmux >/dev/null 2>&1 && tmux;
fi
