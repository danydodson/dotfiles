#!/bin/bash

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }

_zshrc="$DOTFILES/config/zsh/.zshrc"

__info "Copying file to $HOME ..."

# copy to ~/.zshrd
cp -p "$_zshrc" "$HOME" && __ok "Copied $_zshrc to $HOME/.zshrc"

# copy to ~/.config/zsh/.zshrc
cp -p "$_zshrc" "$HOME/.config/zsh" && __ok "Copied $_zshrc to $HOME/.config/zsh/.zshrc"
