# These aliases should be readable by any shell rc file

# General aliases
alias l="ls -ABGh --group-directories-first"
alias ls='ls -GFh --color=auto'
alias ll="ls -ABhl --group-directories-first"
alias la="ll"
alias lt="ls -ABGhlt --group-directories-first"
alias lr="ls -ABGhR --group-directories-first | less"
alias jn='jupyter notebook'
alias njn='nohup jupyter notebook --ip=127.0.0.1 &'
alias reload='source ~/.bashrc'

alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias jsonpp="python -m json.tool"

# Docker
dockerexec() {
  # TODO: Test if sudo is needed?
  sudo docker exec -it --env COLUMNS=`tput cols` --env LINES=`tput lines` "$@"
}
dps() {
  sudo docker ps --format 'table {{.Names}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}' "$@"
}

# vim
alias vp="vim -p"
alias vo="vim -o"
alias vO="vim -O"

# tmux

tmuxclsession() {
  for pane in $(tmux list-panes -s -t $1 -F '#{pane_id}'); do
    tmux send-keys -t $pane 'C-l'
  done
}
abcdcl() {
  tmuxclsession abcd
  # for pane in $(tmux list-panes -s -t abcd -F '#{pane_id}'); do
  #   tmux send-keys -t $pane 'C-l'
  # done
}

# IPython
pandas () {
  python -c "from IPython import embed; import pandas as pd; df = pd.read_csv('$1'); embed()"
}

# Self-referential
alias eb="vim ~/.bashrc && source ~/.bashrc"
alias ea="vim ~/dotfiles/shell/aliases.sh && source ~/dotfiles/shell/aliases.sh"

# Git aliases
alias ga='git add'
alias gapa='git add --patch'

alias gc='git commit -v'
alias gc!='git commit -v --amend'

alias gcm='git checkout master'
alias gco='git checkout'
alias gc-='git checkout --'
alias gcmsg='git commit -m'

alias gd='git diff'
alias gdc='git diff --cached'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdw='git diff --word-diff'
alias gdpy='git diff **/*.py'

alias glg='git log --stat'
alias glga='GIT_PAGER=less git log --oneline --decorate --graph --all'

alias grbm='git rebase master'

alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gru='git reset --'

alias gsb='git status -sb'
alias gst='git status'

alias stash='git stash'
alias unstash='git stash pop'

alias gp='git push'
parse_git_branch_bare() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
gpuo() {
  git push -u origin "$(parse_git_branch_bare)"
}

alias gl='git pull'
alias branches='git branch -vvv'

# Homebrew aliases
if  type direnv >/dev/null 2>&1 ; then
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
fi
