# Source global definitions
if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

source ~/.bash/common
source ~/.bash/prompt
source ~/.bash/git
source ~/.bash/neopoly
source ~/.bash/zilium
source ~/.bash/rvm

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
