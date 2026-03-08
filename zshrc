# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export PYENV_ROOT="$HOME/.pyenv"

export PATH=$HOME/bin:/usr/local/opt/gnu-sed/libexec/gnubin:$HOME/go/bin:$HOME/.pyenv/bin:$HOME/.local/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export ZSH="${HOME}/.oh-my-zsh"
DEFAULT_USER=$(whoami)

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git vi-mode z kubectl)

source $ZSH/oh-my-zsh.sh

export EDITOR="nvim"

alias d="dirs -v | head -10"

# Aliases

alias ag="rg"

export KUBECONFIG="$HOME/.kube/config"

alias gst="git status -u"

## Kubernetes Aliases
alias kg="kubectl get"
alias kd="kubectl describe"
alias ke="kubectl edit"
alias kr="kubectl rollout"
alias kgvs="kubectl get virtualservice"
alias kdvs="kubectl describe virtualservice"
alias kerec="kubectl patch --type=json -p '[{\"op\": \"add\", \"path\": \"/metadata/annotations/argocd.argoproj.io~1skip-reconcile\", \"value\": \"true\"}]' application"
alias kdelrec="kubectl patch --type=json -p '[{\"op\": \"remove\", \"path\": \"/metadata/annotations/argocd.argoproj.io~1skip-reconcile\"}]' application"
alias kdelcache="rm ~/.kube/cache/oidc-login/*"

alias htsbx="helm template . --values env/sbx/values.yaml --values env/sbx/aws/values.yaml"

alias vi="nvim"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export GOPATH=~/src
export PATH=$PATH:$(go env GOPATH)/bin
export HUB=""

export SCW_ACCESS_KEY=$(security find-generic-password -a "$USER" -s "SCW_ACCESS_KEY" -w)
export SCW_SECRET_KEY=$(security find-generic-password -a "$USER" -s "SCW_SECRET_KEY" -w)
export SCW_DEFAULT_ORGANIZATION_ID=$(security find-generic-password -a "$USER" -s "SCW_DEFAULT_ORGANIZATION_ID" -w)
export SCW_DEFAULT_PROJECT_ID=$(security find-generic-password -a "$USER" -s "SCW_DEFAULT_PROJECT_ID" -w)

export HCLOUD_TOKEN=$(security find-generic-password -a "$USER" -s "HCLOUD_TOKEN" -w)

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

export GPG_TTY=$(tty)
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
