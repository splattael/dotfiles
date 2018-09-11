# Source global definitions
if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

source ~/.bash/common
source ~/.bash/hub
source ~/.bash/docker
source ~/.bash/history
source ~/.bash/elm
source ~/.bash/prompt
source ~/.bash/bin
source ~/.bash/git
source ~/.bash/zilium
source ~/.bash/rvm
source ~/.bash/node
source ~/.bash/rust
source ~/.bash/ruby
source ~/.bash/screen
source ~/.bash/nvm
source ~/.bash/private
source ~/.bash/asdf

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
