# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# shellcheck shell=bash
# shellcheck disable=SC1090,SC1091

#
# Browser
#
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#
export EDITOR='vim'
export VISUAL='code'
export PAGER='less'

if [[ -z "$LANG" ]]; then
  export LANG="en_US.UTF-8"
  export LC_COLLATE="en_US.UTF-8"
  export LC_CTYPE="en_US.UTF-8"
fi


export PATH=$PATH:$HOME/.local/bin/:/usr/local/bin:/usr/local/sbin


if [[ "$OSTYPE" == darwin* ]]; then
  pman() {
      man -t "${@}" | open -f -a /Applications/Preview.app/
  }
fi

# gpg
if type "gpgconf" > /dev/null; then
  gpgconf --launch gpg-agent
  GPG_TTY=$(/usr/bin/tty)
  SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
  export GPG_TTY SSH_AUTH_SOCK
fi


export GOPATH="${HOME}/dev/go"
export PATH="$PATH:${GOPATH}/bin"



export ERL_AFLAGS="-kernel shell_history enabled"



if [[ -d "/home/linuxbrew/" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi


# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# use ls color
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad



# MS TFS client
export TF_AUTO_SAVE_CREDENTIALS=1
export TF_DIFF_COMMAND="bcomp %1 %2"



# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X";


#docker
#export DOCKER_CONTENT_TRUST=1
#export DOCKER_BUILDKIT=1


# configure prompt to not show username
export DEFAULT_USER=$USER

#PATH 
export PATH="/usr/local/git-tf:/usr/local/tee-clc:$PATH"
export PATH=~/bin:$PATH
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH=$HOME/.dotnet/tools:$PATH
if [[ "$OSTYPE" == darwin* ]]; then
  export PATH=$PATH:$HOME/Library/Python/3.7/bin
fi


source "${HOME}/antigen/antigen.zsh"
antigen init ~/.antigenrc

# homebrew zsh completions
# shellcheck disable=SC2206
if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

test -e "${HOME}/.asdf/asf.sh" && source "$HOME/.asdf/asdf.sh"
test -e "$HOME/.asdf/completions/asdf.bash" &&. "$HOME/.asdf/completions/asdf.bash"



# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/Users/martin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

_dotnet_zsh_complete() 
{
  # shellcheck disable=SC2034
  local completions=("$(dotnet complete "$words")")
  # shellcheck disable=SC2034
  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet


alias ll='ls -GAlhp'
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias gs="git status"

# openssl + ansible
#export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/opt/openssl/lib:$DYLD_FALLBACK_LIBRARY_PATH

if type "kubectl" > /dev/null; then
  source <(kubectl completion zsh)
fi

# jfrog-cli 
if [[ -e "$HOME/.jfrog/jfrog_zsh_completion" ]]; then
  source "$HOME/.jfrog/jfrog_zsh_completion"
fi

#helm 2
if [[ -d "/usr/local/opt/helm@2/bin" ]]; then
  PATH="$PATH:/usr/local/opt/helm@2/bin"
  # shellcheck disable=SC2128,SC2206
  fpath=(/usr/local/opt/helm@2/share/zsh/site-functions $fpath)
fi


# use secretive SSH agent if present
test -e "$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh" && export SSH_AUTH_SOCK=$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh


if [[ -e "${HOME}/.iterm2_shell_integration.zsh" ]]; then
  source "${HOME}/.iterm2_shell_integration.zsh"
fi

# minikube
export MINIKUBE_HOME=/Volumes/SamsungT5/minikube

# vagrant settings
export VAGRANT_DEFAULT_PROVIDER=parallels

# fastlane
test -e "${HOME}/.fastlane/completions/completion.sh" &&  . "${HOME}/.fastlane/completions/completion.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Show prompt segment "kubecontext" only when the command you are typing
# invokes kubectl, helm, kubens, kubectx, oc, istioctl, kogito, k9s or helmfile.
typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubctx'export PATH="/usr/local/opt/curl/bin:$PATH"

# Android SDK
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk/
export PATH=$ANDROID_SDK_ROOT/platform-tools/:$PATH
