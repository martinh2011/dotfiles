# Executes commands at login pre-zshrc.

#
# load .profile if any
#
[ -f ~/.profile ] && source ~/.profile

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
  export LANG='en_US.UTF-8'
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


#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

if [[ "$OSTYPE" == darwin* ]]; then
  pman() {
      man -t ${@} | open -f -a /Applications/Preview.app/
  }
fi

GPG_TTY=$(/usr/bin/tty)
SSH_AUTH_SOCK="$HOME/.gnupg/S.gpg-agent.ssh"
export GPG_TTY SSH_AUTH_SOCK

# Go development
export GOPATH="${HOME}/dev/go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Erlang/Elixir
export ERL_AFLAGS="-kernel shell_history enabled"
alias config='git --git-dir=/Users/martin/.cfg/ --work-tree=/Users/martin'
