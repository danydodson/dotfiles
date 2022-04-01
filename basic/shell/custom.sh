#!/bin/bash

# aliases

alias src=". ~/.zshrc"
alias c="clear"

alias dots="cd ~/.dotfiles && code ."
alias dotinstall="cd ~/.dotfiles && sh scripts/dotfiles-install.sh "

alias buu="brew update && brew upgrade && brew cleanup && brew doctor"

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# fzf - https://github.com/junegunn/fzf
if [[ -f ~/.fzf.zsh ]]; then
  # shellcheck disable=SC1090
  source ~/.fzf.zsh
fi

alias preview="fzf --preview 'bat --color \"always\" {}'"

# add support for ctrl+o to open selected file in the default text editor
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(e {})+abort'"

# asdf - https://asdf-vm.com/
alias a='asdf'

# shellcheck disable=SC1091
source "$(brew --prefix asdf)/libexec/asdf.sh"
