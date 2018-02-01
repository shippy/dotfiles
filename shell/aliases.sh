# These aliases should be readable by any shell rc file

# General aliases
alias l="ls -la"
alias jn='jupyter notebook'
alias reload='source ~/.bashrc'

alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Git aliases
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcam='git commit -a -m'

alias gcm='git checkout master'
alias gco='git checkout'
alias gc-='git checkout --'
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

alias gp='git push'
