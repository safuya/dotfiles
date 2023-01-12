# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PYENV_ROOT="$HOME/.pyenv"

export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:$HOME/bin:$HOME/go/bin:$HOME/.pyenv/bin:$HOME/.local/bin:$HOME/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export ZSH="${HOME}/.oh-my-zsh"
DEFAULT_USER=$(whoami)

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git poetry vi-mode z tmux kubectl)

source $ZSH/oh-my-zsh.sh

export EDITOR="nvim"
export CF_RUNNING=('CREATE_IN_PROGRESS' 'CREATE_COMPLETE' 'ROLLBACK_IN_PROGRESS' 'ROLLBACK_FAILED' 'ROLLBACK_COMPLETE' 'DELETE_IN_PROGRESS' 'DELETE_FAILED' 'UPDATE_IN_PROGRESS' 'UPDATE_COMPLETE_CLEANUP_IN_PROGRESS' 'UPDATE_COMPLETE' 'UPDATE_ROLLBACK_IN_PROGRESS' 'UPDATE_ROLLBACK_FAILED' 'UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS' 'UPDATE_ROLLBACK_COMPLETE' 'REVIEW_IN_PROGRESS')
export CF_DEAD=('CREATE_FAILED' 'DELETE_COMPLETE')

alias d="dirs -v | head -10"

# Aliases

alias watch="watch "
alias t="tmux"

alias kg="kubectl get"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export GOPATH=~/go
export HUB=""

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

export GPG_TTY=$(tty)
export TF_VAR_github_token=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
export GITHUB_USERNAME=safuya
export GITHUB_REPO_TOKEN=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
eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sophiehughes/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sophiehughes/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sophiehughes/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sophiehughes/google-cloud-sdk/completion.zsh.inc'; fi
