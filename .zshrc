zmodload zsh/zprof

#
# antigen
#
source ${HOME}/antigen/antigen.zsh
antigen init .antigenrc

# homebrew zsh completions
fpath=(/usr/local/share/zsh-completions $fpath)

# zsh parameter completion for the dotnet CLI
_dotnet_zsh_complete() 
{
  local dotnetPath=$words[1]

  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet


bash_source() {
  alias shopt=':'
  alias _expand=_bash_expand
  alias _complete=_bash_comp
  emulate -L sh
  setopt kshglob noshglob braceexpand

  source "$@"
}

autoload bashcompinit
bashcompinit
test -e $HOME/.dvm/bash_completion && bash_source $HOME/.dvm/bash_completion

# sourcetree
alias stree='/Applications/SourceTree.app/Contents/Resources/stree'

# use ls color
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# MS TFS client
export TF_AUTO_SAVE_CREDENTIALS=1
export TF_DIFF_COMMAND="bcomp %1 %2"

# use local, non-root gem
export GEM_HOME=$HOME/.gem

# utf-8
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X";


#docker
#export DOCKER_CONTENT_TRUST=1

# docker version manager
test -e $HOME/.dvm/dvm.sh && source $HOME/.dvm/dvm.sh > /dev/null

# go
export GOPATH=~/Dev/go

# Android
if [[ -d $HOME/Library/Android/sdk ]]; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export ANDROID_NDK_HOME=$ANDROID_HOME/ndk-bundle
  # android studio jdk
  export STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/
fi


export PATH="/usr/local:/usr/local/git-tf:/usr/local/tee-clc:$PATH"
export PATH=$GEM_HOME/bin:$PATH
export PATH=~/bin:$PATH
export PATH=/usr/local/opt/go/libexec/bin:$PATH
export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/opt/openssl/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

