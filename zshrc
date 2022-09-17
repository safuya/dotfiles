# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/openssl@1.1/bin:$HOME/bin:$HOME/go/bin:$HOME/.pyenv/shims:$HOME/.poetry/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:/Applications/Postgres.app/Contents/Versions/12/bin:$PATH"

export ZSH="${HOME}/.oh-my-zsh"
DEFAULT_USER=$(whoami)

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
# ENABLE_CORRECTION="true"

plugins=(git poetry vi-mode z tmux zsh-completions kubectl)

source $ZSH/oh-my-zsh.sh
source /usr/local/bin/aws_zsh_completer.sh

export EDITOR="vim"
export CF_RUNNING=('CREATE_IN_PROGRESS' 'CREATE_COMPLETE' 'ROLLBACK_IN_PROGRESS' 'ROLLBACK_FAILED' 'ROLLBACK_COMPLETE' 'DELETE_IN_PROGRESS' 'DELETE_FAILED' 'UPDATE_IN_PROGRESS' 'UPDATE_COMPLETE_CLEANUP_IN_PROGRESS' 'UPDATE_COMPLETE' 'UPDATE_ROLLBACK_IN_PROGRESS' 'UPDATE_ROLLBACK_FAILED' 'UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS' 'UPDATE_ROLLBACK_COMPLETE' 'REVIEW_IN_PROGRESS')
export CF_DEAD=('CREATE_FAILED' 'DELETE_COMPLETE')

alias d="dirs -v | head -10"

# Aliases

alias watch="watch "
alias t="tmux"
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

SSH_ENV="$HOME/.ssh/agent-environment"
export APPLE_SSH_ADD_BEHAVIOR="openssh"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/sophie.hughes/.sdkman"
[[ -s "/Users/sophie.hughes/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/sophie.hughes/.sdkman/bin/sdkman-init.sh"

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
source ~/src/andy.howard/oobshellnew/complete-oobshell

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

complete -o nospace -C /Users/sophie.hughes/bin/terraform terraform

export PATH="$HOME/.poetry/bin:$PATH"
export GPG_TTY=$(tty)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
