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

#
# Language
#
if [[ -z "$LANG" ]]; then
  export LANG="en_US.UTF-8"
  export LC_COLLATE="en_US.UTF-8"
  export LC_CTYPE="en_US.UTF-8"
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

if [[ "$OSTYPE" == darwin* ]]; then
  pman() {
      man -t ${@} | open -f -a /Applications/Preview.app/
  }
fi

# gpg
gpgconf --launch gpg-agent
GPG_TTY=$(/usr/bin/tty)
SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
export GPG_TTY SSH_AUTH_SOCK

# Go development
export GOPATH="${HOME}/dev/go"
export PATH="$PATH:${GOPATH}/bin"

# Erlang/Elixir
export ERL_AFLAGS="-kernel shell_history enabled"

# linux brew
if [[ -d "/home/linuxbrew/" ]]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# use ls color
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# MS TFS client
export TF_AUTO_SAVE_CREDENTIALS=1
export TF_DIFF_COMMAND="bcomp %1 %2"

# use local, non-root gem
export GEM_HOME=$HOME/.gem

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X";


#docker
#export DOCKER_CONTENT_TRUST=1

# docker version manager
test -e $HOME/.dvm/dvm.sh && source $HOME/.dvm/dvm.sh > /dev/null


# Android
if [[ -d $HOME/Library/Android/sdk ]]; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export ANDROID_NDK_HOME=$ANDROID_HOME/ndk-bundle
  # android studio jdk
  export STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/
fi

# configure prompt to not show username
export DEFAULT_USER=$USER

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#PATH 
export PATH="/usr/local/git-tf:/usr/local/tee-clc:$PATH"
export PATH=$GEM_HOME/bin:$PATH
export PATH=~/bin:$PATH
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH=$HOME/.dotnet/tools:$PATH

if [[ "$OSTYPE" == darwin* ]]; then
  export PATH=$PATH:$HOME/Library/Python/3.7/bin
fi


#
# antigen
#
source ${HOME}/antigen/antigen.zsh
antigen init ~/.antigenrc

# homebrew zsh completions
fpath=(/usr/local/share/zsh-completions $fpath)


bash_source() {
  alias shopt=':'
  alias _expand=_bash_expand
  alias _complete=_bash_comp
  emulate -L sh
  setopt kshglob noshglob braceexpand

  source "$@"
}

test -e "${HOME}/.asdf/asf.sh" && source $HOME/.asdf/asdf.sh
test -e "$HOME/.asdf/completions/asdf.bash" &&. $HOME/.asdf/completions/asdf.bash

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/Users/martin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# zsh parameter completion for the dotnet CLI
_dotnet_zsh_complete() 
{
  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet

# adapt prompt for iterm (with status baR)
if [[ "$TERM_PROGRAM" == iTerm.app ]]; then
  export AGNOSTER_PROMPT_SEGMENTS=("prompt_status" "prompt_context" "prompt_virtualenv" "prompt_dir" "prompt_end")
fi

#
# aliases
#
alias ll='ls -GAlhp'
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias stree='/Applications/SourceTree.app/Contents/Resources/stree'
