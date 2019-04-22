# If you come from bash you might have to change your $PATH.
export PATH=$PATH:$HOME/bin

# Path to your oh-my-zsh installation.
export ZSH="/Users/roberthughes/.oh-my-zsh"
DEFAULT_USER=roberthughes

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"
# ENABLE_CORRECTION="true"

plugins=(git vi-mode z tmux)

source $ZSH/oh-my-zsh.sh

. /usr/local/etc/profile.d/z.sh

export EDITOR="vim"

# Aliases
alias gcd="git checkout dev"
alias myip="curl ifconfig.io/ip"
alias t="tmux"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export WORKON_HOME=$HOME/.virtualenvs
pyenv virtualenvwrapper_lazy

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
