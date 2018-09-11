# Source global definitions
if [ -f /etc/bash.bashrc ]; then
  . /etc/bash.bashrc
fi

source ~/.bash/asdf
source ~/.bash/common
source ~/.bash/hub
source ~/.bash/docker
source ~/.bash/history
source ~/.bash/prompt
source ~/.bash/bin
source ~/.bash/git
source ~/.bash/ruby
source ~/.bash/screen

source ~/.bash/private
source ~/.bash/zilium

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
