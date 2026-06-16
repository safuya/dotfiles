# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export ZSH="$HOME/.oh-my-zsh"
export PYENV_ROOT="$HOME/.pyenv"
export GOPATH="$HOME/src"
export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/boxed-config.yaml:$HOME/.kube/boxed-platform-config.yaml"

export EDITOR="nvim"
export VISUAL="$EDITOR"
export GPG_TTY="$TTY"

DEFAULT_USER="$USER"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git vi-mode z kubectl)

typeset -U path PATH
path=(
  "$HOME/bin"
  "$HOME/.local/share/nvim/mason/bin"
  "${KREW_ROOT:-$HOME/.krew}/bin"
  "/usr/local/opt/gnu-sed/libexec/gnubin"
  "$GOPATH/bin"
  "$PYENV_ROOT/bin"
  "$HOME/.local/bin"
  $path
)

# The next line updates PATH for the Google Cloud SDK.
if [[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi

zstyle ':completion:*' menu select
fpath+=("$HOME/.zfunc")
autoload -Uz compinit
compinit

source "$ZSH/oh-my-zsh.sh"

[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

alias d="dirs -v | head -10"
alias ag="rg"
alias grep="rg"
alias gst="git status -u"
alias vi="nvim"

## Kubernetes aliases
alias kg="kubectl get"
alias kd="kubectl describe"
alias ke="kubectl edit"
alias kr="kubectl rollout"
alias kgvs="kubectl get virtualservice"
alias kdvs="kubectl describe virtualservice"
alias kerec="kubectl patch --type=json -p '[{\"op\": \"add\", \"path\": \"/metadata/annotations/argocd.argoproj.io~1skip-reconcile\", \"value\": \"true\"}]' application"
alias kdelrec="kubectl patch --type=json -p '[{\"op\": \"remove\", \"path\": \"/metadata/annotations/argocd.argoproj.io~1skip-reconcile\"}]' application"
alias kdelcache="rm ~/.kube/cache/oidc-login/*"
export dry=(--dry-run=client -o yaml)

alias htsbx="helm template . --values env/sbx/values.yaml --values env/sbx/aws/values.yaml"

brew() {
  env PATH="${PATH//$PYENV_ROOT\/shims:/}" command brew "$@"
}

eval "$(pyenv init -)"

export NVM_DIR="$HOME/.nvm"
if [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
  source "/opt/homebrew/opt/nvm/nvm.sh"
fi

autoload -U +X bashcompinit && bashcompinit
if [[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ]]; then
  source "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
fi

export SCW_ACCESS_KEY="$(security find-generic-password -a "$USER" -s "SCW_ACCESS_KEY" -w)"
export SCW_SECRET_KEY="$(security find-generic-password -a "$USER" -s "SCW_SECRET_KEY" -w)"
export SCW_DEFAULT_ORGANIZATION_ID="$(security find-generic-password -a "$USER" -s "SCW_DEFAULT_ORGANIZATION_ID" -w)"
export SCW_DEFAULT_PROJECT_ID="$(security find-generic-password -a "$USER" -s "SCW_DEFAULT_PROJECT_ID" -w)"
export HCLOUD_TOKEN="$(security find-generic-password -a "$USER" -s "HCLOUD_TOKEN" -w)"
export NPM_AUTH="$(security find-generic-password -a "$USER" -s "NPM_AUTH" -w)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# The next line enables shell command completion for gcloud.
if [[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]]; then
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi
