#!/bin/bash

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }

_file="$HOME/Developer/Dotfiles/config/zsh/.zshrc"

__info "Copying file to $HOME ..."

cp -p "$_file" "$HOME" &&  __ok "Copied $_file to $HOME"
