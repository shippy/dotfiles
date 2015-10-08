# Set distribution-specific things (ZSH, PATH, BROWSER, TERM, ...)
# dotty takes care of the initial setup -- only sync the file to home
# for a given distribution
[ -f ~/.zshrc_osx ] && source ~/.zshrc_osx
[ -f ~/.zshrc_crouton ] && source ~/.zshrc_crouton
[ -f ~/.zshrc_hpc ] && source ~/.zshrc_hpc

# Set name of the oh-my-zsh theme to load.
ZSH_THEME="bira"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# enable command auto-correction.
ENABLE_CORRECTION="true"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

setopt AUTO_CD

## Aliases
alias t='python ~/bin/t/t.py'

## Final commands
# autorun tmux if it (1) is not running yet, (2) exists
if [ "$TMUX" = "" ]; then 
  command -v tmux >/dev/null 2>&1 && tmux;
fi
