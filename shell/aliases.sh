# These aliases should be readable by any shell rc file

# General aliases
alias l="ls -ABGGh --group-directories-first"
alias ll="ls -ABGGhl --group-directories-first"
alias lt="ls -ABGGhlt --group-directories-first"
alias lr="ls -ABGGh --group-directories-first | less"
alias jn='jupyter notebook'
alias njn='nohup jupyter notebook --ip=127.0.0.1 &'
alias reload='source ~/.bashrc'

alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias jsonpp="python -m json.tool"

# Self-referential
alias ez="vim ~/.zshrc && source ~/.zshrc"
alias eb="vim ~/.bashrc && source ~/.bashrc"
alias ea="vim ~/dotfiles/shell/aliases.sh && source ~/dotfiles/shell/aliases.sh"

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
alias glga='GIT_PAGER=less git log --oneline --decorate --graph --all'

alias grbm='git rebase master'

alias grhh='git reset HEAD --hard'
alias gru='git reset --'

alias gsb='git status -sb'
alias gst='git status'

alias stash='git stash'
alias unstash='git stash pop'

alias gp='git push'
