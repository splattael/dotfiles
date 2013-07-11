# Source global definitions
if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

source ~/.bash/common
source ~/.bash/prompt
source ~/.bash/git
source ~/.bash/zilium
source ~/.bash/rvm
source ~/.bash/ruby
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
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s $HOME/.nvm/nvm.sh ]] && source $HOME/.nvm/nvm.sh # This loads NVM

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
