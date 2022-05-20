#!/bin/bash

# Log Helpers
. "$HOME/Developer/Dotfiles/utils/helpers.sh"
. "$HOME/Developer/Dotfiles/utils/pretty.bash"

_file="$HOME/Developer/Dotfiles/config/zsh/.zshrc"

__info "Copying file to $HOME ..."

cp -p "$_file" "$HOME" &&  __ok "Copied $_file to $HOME"
