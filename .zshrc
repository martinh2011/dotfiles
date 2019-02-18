#
# antigen
#
source ${HOME}/antigen/antigen.zsh
antigen init ~/.antigenrc

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

test -e "${HOME}/.asdf/asf.sh" && source $HOME/.asdf/asdf.sh
test -e "$HOME/.asdf/completions/asdf.bash" &&. $HOME/.asdf/completions/asdf.bash

