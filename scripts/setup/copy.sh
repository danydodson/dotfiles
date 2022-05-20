#!/bin/bash

# Log Helpers
. "$HOME/Developer/Dotfiles/utilities/helpers.sh"
. "$HOME/Developer/Dotfiles/utilities/pretty.bash"

_file="$HOME/Developer/Dotfiles/config/zsh/.zshrc"

__info "Copying file to $HOME ..."

cp -p "$_file" "$HOME" &&  __ok "Copied $_file to $HOME"
