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

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/opt/python/libexec/bin
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



export GOPATH="${HOME}/dev/go"
export PATH="$PATH:${GOPATH}/bin"



export ERL_AFLAGS="-kernel shell_history enabled"



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



export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH



# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X";


#docker
#export DOCKER_CONTENT_TRUST=1


# configure prompt to not show username
export DEFAULT_USER=$USER

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#PATH 
export PATH="/usr/local/git-tf:/usr/local/tee-clc:$PATH"
export PATH=~/bin:$PATH
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH=$HOME/.dotnet/tools:$PATH
if [[ "$OSTYPE" == darwin* ]]; then
  export PATH=$PATH:$HOME/Library/Python/3.7/bin
fi



source ${HOME}/antigen/antigen.zsh
antigen init ~/.antigenrc



# homebrew zsh completions
fpath=(/usr/local/share/zsh-completions $fpath)



test -e "${HOME}/.asdf/asf.sh" && source $HOME/.asdf/asdf.sh
test -e "$HOME/.asdf/completions/asdf.bash" &&. $HOME/.asdf/completions/asdf.bash



# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/Users/martin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

_dotnet_zsh_complete() 
{
  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet


alias ll='ls -GAlhp'
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias stree='/Applications/SourceTree.app/Contents/Resources/stree'
alias -s log="tail -f"
alias gs="git status"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard | fd --type f --type l $FD_OPTIONS"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# GIT heart FZF
# -------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -'$LINES
}

gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
  grep -o "[a-f0-9]\{7,\}"
}

gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}
bind-git-helper f b t r h
unset -f bind-git-helper

# openssl + ansible
#export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/opt/openssl/lib:$DYLD_FALLBACK_LIBRARY_PATH