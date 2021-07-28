# TODO: Almost all of this should really be machine-dependent, sourced from a
# local file instead of hoping that the Mac folders will generalize on all
# other machines...

# zsh config
skip_global_compinit=1

# Due to a WSL bug: Microsoft/BashOnWindows#1887
unsetopt BG_NICE

# zsh-related globals
if [ -d /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# Various globals
if [ -d /usr/libexec ] && [ -f /usr/libexec/java_home ]; then
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
fi
if [ -d /Applications/MATLAB_R2016b.app/bin ]; then
  export MATLAB_EXECUTABLE="/Applications/MATLAB_R2016b.app/bin/matlab"
fi

## Path!
typeset -U path # only unique entries

# # Prepending
# path=($HOME/anaconda/bin \
#       $HOME/anaconda2/bin \
#       ~/.linuxbrew/bin \
#       ~/.linuxbrew/sbin \
#       /usr/local/opt/coreutils/libexec/gnubin \
#       /usr/local/opt/gdal2/bin \
#       $path)

# Appending
path+=($HOME/anaconda/bin \
       $HOME/anaconda2/bin \
       ~/.linuxbrew/bin \
       ~/.linuxbrew/sbin \
       /usr/local/opt/coreutils/libexec/gnubin \
       /usr/local/opt/gdal2/bin \
       /usr/local/sbin \
       /home/simon/.local/bin \
       $HOME/bin \
       /usr/local/mysql/bin \
       /usr/local/bin \
       /usr/local/heroku/bin \
       $HOME/bin/pybib)
if [ -d ${MATLAB_EXECUTABLE:h} ]; then
  path+=(${MATLAB_EXECUTABLE:h})
fi
