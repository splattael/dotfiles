# Source global definitions
if [ -f /etc/bash.bashrc ]; then
  . /etc/bash.bashrc
fi

source ~/.bash/asdf
source ~/.bash/bin
source ~/.bash/common
source ~/.bash/docker
source ~/.bash/fzf
source ~/.bash/git
source ~/.bash/golang
source ~/.bash/hub
source ~/.bash/history
source ~/.bash/kubernetes
source ~/.bash/prompt
source ~/.bash/ruby
source ~/.bash/tmux

source ~/.bash/private
source ~/.bash/gitlab
source ~/.bash/zilium

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

HISTCONTROL=ignoredups:erasedups
