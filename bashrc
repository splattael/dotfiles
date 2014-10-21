# Source global definitions
if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

source ~/.bash/common
source ~/.bash/history
source ~/.bash/prompt
source ~/.bash/bin
source ~/.bash/git
source ~/.bash/zilium
source ~/.bash/rvm
source ~/.bash/nvm
source ~/.bash/ruby
source ~/.bash/go
source ~/.bash/screen

if [ "$(domainname)" = "NEOPOLY" ]; then
  source ~/.bash/neopoly
else
  source ~/.bash/private
fi

# use .localrc for settings specific to one system
if [ -f ~/.localrc ]; then
  source ~/.localrc
fi
