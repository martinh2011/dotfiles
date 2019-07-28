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


# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f $HOME/.asdf/installs/nodejs/11.10.1/.npm/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/martin/.asdf/installs/nodejs/11.10.1/.npm/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.zsh

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/Users/martin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload bashcompinit
bashcompinit
test -e $HOME/.dvm/bash_completion && bash_source $HOME/.dvm/bash_completion

# zsh parameter completion for the dotnet CLI
_dotnet_zsh_complete() 
{
  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet

# adapt prompt for iterm (with status bae)
if [[ "$TERM_PROGRAM" == iTerm.app ]]; then
echo #### adapt prompt
  export AGNOSTER_PROMPT_SEGMENTS=("prompt_status" "prompt_context" "prompt_virtualenv" "prompt_dir" "prompt_end")
fi
