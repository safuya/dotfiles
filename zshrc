export PATH=/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/openssl@1.1/bin:$PATH:$HOME/bin:$HOME/go/bin:$HOME/.pyenv/shims/aws_completer:$HOME/.poetry/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:/Applications/Postgres.app/Contents/Versions/12/bin:$PATH"

export ZSH="${HOME}/.oh-my-zsh"
DEFAULT_USER=$(whoami)

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robnoster"
# ENABLE_CORRECTION="true"

plugins=(git vi-mode z tmux kubectl zsh-completions nvm)

source $ZSH/oh-my-zsh.sh
source <(stern --completion=zsh)
source /usr/local/bin/aws_zsh_completer.sh

export EDITOR="vim"
export CF_RUNNING=('CREATE_IN_PROGRESS' 'CREATE_COMPLETE' 'ROLLBACK_IN_PROGRESS' 'ROLLBACK_FAILED' 'ROLLBACK_COMPLETE' 'DELETE_IN_PROGRESS' 'DELETE_FAILED' 'UPDATE_IN_PROGRESS' 'UPDATE_COMPLETE_CLEANUP_IN_PROGRESS' 'UPDATE_COMPLETE' 'UPDATE_ROLLBACK_IN_PROGRESS' 'UPDATE_ROLLBACK_FAILED' 'UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS' 'UPDATE_ROLLBACK_COMPLETE' 'REVIEW_IN_PROGRESS')
export CF_DEAD=('CREATE_FAILED' 'DELETE_COMPLETE')

alias ctags="/usr/local/Cellar/ctags/5.8_1/bin/ctags"
alias d="dirs -v | head -10"

# Aliases

alias watch="watch "
alias xargs="xargs "
alias t="tmux"
alias decode="pbpaste | base64 -d"
alias awsprofiles="< ~/.aws/credentials| grep '\[*\]'"

alias o="openstack"
alias ost="openstack stack"
alias os="openstack server"
alias ov="openstack volume"

## Add kubectl context to the prompt
zsh_prompt() {
  KUBECTL_CONTEXT=$(kubectl config current-context)
  KUBECTL_NAMESPACE=$(kubectl config get-contexts | grep "*" | awk '{print $NF}')
  ZSH_KUBECTL_PROMPT="${KUBECTL_CONTEXT}/${KUBECTL_NAMESPACE}"
  prompt_segment '' '' "${ZSH_KUBECTL_PROMPT} "
}
AGNOSTER_PROMPT_SEGMENTS=("zsh_prompt" "${AGNOSTER_PROMPT_SEGMENTS[@]}")


check_certs() {
  setopt shwordsplit
  local SECRET=$1; shift
  local GET_ARGS="$@"
  local RETURN=0

  CERTS=$(
    for PEM in $(kubectl get secret ${GET_ARGS} ${SECRET} -ojson | \
                 jq -r '.data | ."cert-chain.pem", ."root-cert.pem"'); do
      echo ${PEM} | base64 -d
    done \
      | xargs \
      | sed -e 's/ //g' -e 's/-----[^-]*-----/ /g')

  for CERT in ${CERTS}; do
    echo -e "-----BEGIN CERTIFICATE-----\n${CERT}\n-----END CERTIFICATE-----" \
    | openssl x509 -noout -checkend 0 -enddate
    ((RETURN+=$?))
  done
  unsetopt shwordsplit

  return ${RETURN}
}

invalid_istio_secrets() {
  while read line; do
    local secret=$(echo $line | awk '{print $2}')
    local namespace=$(echo $line | awk '{print $1}')
    if ! check_certs ${secret} -n ${namespace} > /dev/null; then
      echo "${line}"
    fi
  done < <(kubectl get secret --field-selector type=istio.io/key-and-cert --all-namespaces --no-headers)
}

delete_invalid_istio_secrets() {
  while read line; do
    local secret=$(echo $line | awk '{print $2}')
    local namespace=$(echo $line | awk '{print $1}')
    echo "kubectl delete secret ${secret} -n ${namespace}"
    kubectl delete secret ${secret} -n ${namespace}
  done < <(invalid_istio_secrets)
}

## Aliases

### Kubectl

alias kc="kubectl config"
alias kcv="kubectl config view"
alias kcgc="kubectl config get-contexts"
alias kcuc="kubectl config use-context"
alias kd="kubectl describe"
alias kdrs="kubectl describe rs"
alias ke="kubectl edit"
alias kg="kubectl get"
alias kge="kubectl get events"
alias kgef="kubectl get events --sort-by='{lastTimestamp}' --field-selector type!=Normal"
alias kgpb="kubectl get pods --all-namespaces | grep -v Running | grep -v Completed"
alias kgpsum="kubectl get pods --all-namespaces --no-headers -o=custom-columns=Status:.status.phase | sort | uniq -c"
alias kgrs="kubectl get rs"
alias kl="kubectl logs --timestamps"
alias klf="kubectl logs --timestamps -f"
alias kr="kubectl rollout"

### Istioctl

alias i="istioctl"
alias ia="istioctl authn"
alias iat="istioctl authn tls-check"
alias ipc="istioctl proxy-config"
alias ipcb="istioctl proxy-config bootstrap"
alias ipcc="istioctl proxy-config cluster"
alias ipce="istioctl proxy-config endpoint"
alias ipcl="istioctl proxy-config listeners"
alias ipcr="istioctl proxy-config route"
alias ips="istioctl proxy-status"

# pyenv

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
export WORKON_HOME=$HOME/.virtualenvs
pyenv virtualenvwrapper_lazy

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export GOPATH=~/go
export ISTIO=$GOPATH/src/istio.io
export HUB=""

autoload -U +X bashcompinit && bashcompinit

export PATH="$PATH:$HOME/.rvm/bin"
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/kustomize kustomize

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/opt/openjdk/bin:$PATH"
