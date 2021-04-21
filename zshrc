export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/openssl@1.1/bin:$HOME/bin:$HOME/go/bin:$HOME/.pyenv/shims/aws_completer:$HOME/.poetry/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:/Applications/Postgres.app/Contents/Versions/12/bin:$PATH"

export ZSH="${HOME}/.oh-my-zsh"
DEFAULT_USER=$(whoami)

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robnoster"
# ENABLE_CORRECTION="true"

plugins=(git poetry vi-mode z tmux zsh-completions)

source $ZSH/oh-my-zsh.sh
source /usr/local/bin/aws_zsh_completer.sh

export EDITOR="vim"
export CF_RUNNING=('CREATE_IN_PROGRESS' 'CREATE_COMPLETE' 'ROLLBACK_IN_PROGRESS' 'ROLLBACK_FAILED' 'ROLLBACK_COMPLETE' 'DELETE_IN_PROGRESS' 'DELETE_FAILED' 'UPDATE_IN_PROGRESS' 'UPDATE_COMPLETE_CLEANUP_IN_PROGRESS' 'UPDATE_COMPLETE' 'UPDATE_ROLLBACK_IN_PROGRESS' 'UPDATE_ROLLBACK_FAILED' 'UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS' 'UPDATE_ROLLBACK_COMPLETE' 'REVIEW_IN_PROGRESS')
export CF_DEAD=('CREATE_FAILED' 'DELETE_COMPLETE')

alias d="dirs -v | head -10"

# Aliases

alias watch="watch "
alias t="tmux"
alias decode="pbpaste | base64 -d"
alias awsprofiles="< ~/.aws/credentials| grep '\[*\]' | sed 's/\[//' | sed 's/]//'"
alias vw="vim -c VimwikiIndex"

# pyenv

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export WORKON_HOME=$HOME/.virtualenvs
pyenv virtualenvwrapper_lazy

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export GOPATH=~/go
export HUB=""

export PATH="$PATH:$HOME/.rvm/bin"
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/kustomize kustomize

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/robert.hughes4/.sdkman"
[[ -s "/Users/robert.hughes4/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/robert.hughes4/.sdkman/bin/sdkman-init.sh"

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

complete -o nospace -C /Users/robert.hughes4/bin/terraform terraform

export PATH="$HOME/.poetry/bin:$PATH"
