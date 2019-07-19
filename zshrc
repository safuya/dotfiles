# If you come from bash you might have to change your $PATH.
export PATH=$PATH:$HOME/bin:$HOME/go/bin

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
DEFAULT_USER=$(whoami)

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"
# ENABLE_CORRECTION="true"

plugins=(git vi-mode z tmux kubectl)

source $ZSH/oh-my-zsh.sh

export EDITOR="vim"

alias ctags="/usr/local/Cellar/ctags/5.8_1/bin/ctags"
alias d="dirs -v | head -10"

# Aliases
alias myip="curl ifconfig.io/ip"
alias t="tmux"

# K8S
if [ "$(whoami)" = 'robert.hughes4' ]; then
  ## Add extra namespaces for kubeconfig from git repo's
  export KUBECONFIG=${HOME}/.kube/config:/Users/robert.hughes4/src/kubernetes/overview-docs/files/kubeconfig
fi

## Add kubectl context to the prompt
zsh_prompt() {
  KUBECTL_CONTEXT=$(kubectl config current-context | sed 's|arn:aws:eks:eu-west-1:165746544353:cluster/||')
  KUBECTL_NAMESPACE=$(kubectl config get-contexts | grep "*" | awk '{print $NF}')
  ZSH_KUBECTL_PROMPT="${KUBECTL_CONTEXT}/${KUBECTL_NAMESPACE}"
  prompt_segment '' '' "${ZSH_KUBECTL_PROMPT} "
}
AGNOSTER_PROMPT_SEGMENTS=("zsh_prompt" "${AGNOSTER_PROMPT_SEGMENTS[@]}")

## Aliases
alias kc="kubectl config"
alias kcv="kubectl config view"
alias kcgc="kubectl config get-contexts"
alias kcuc="kubectl config use-context"
alias kd="kubectl describe"
alias kdrs="kubectl describe rs"
alias kg="kubectl get"
alias kgrs="kubectl get rs"
alias kr="kubectl rollout"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export WORKON_HOME=$HOME/.virtualenvs
pyenv virtualenvwrapper_lazy

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export GOPATH=~/go

autoload -U +X bashcompinit && bashcompinit
