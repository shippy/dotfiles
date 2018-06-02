# zsh-specific aliases that bash doesn't need / can't
# handle

# Commonly used aliases from oh-my-zsh/common-aliases
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"

alias aG='alias G'

alias ez="vim ~/.zshrc && source ~/.zshrc"
alias sz="source ~/.zshrc"

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
