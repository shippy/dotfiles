# zsh config
skip_global_compinit=1

# zsh-related globals
export ZSH=/Users/$(whoami)/.oh-my-zsh
fpath=(/usr/local/share/zsh-completions $fpath)

# Various globals
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export MATLAB_EXECUTABLE="/Applications/MATLAB_R2016b.app/bin/matlab"

## Path!
typeset -U path # only unique entries

# Prepending
path=($HOME/anaconda/bin /usr/local/opt/gdal2/bin $path)

# Appending
path+=(/usr/local/sbin $JAVA_HOME/bin $HOME/bin \
  /usr/local/mysql/bin /usr/local/bin /usr/local/heroku/bin $HOME/bin/pybib /Applications/MATLAB_R2016b.app/bin)
# /Applications/MATLAB_R2016b.app/bin/maci64
