#!/bin/bash

# log Helper
_info() { echo -e "\033[36m[INFO]\033[0m $1"; }
_ok() { echo -e "\033[32m[OK]\033[0m $1"; }

_file="$HOME/Dotfiles/settings/zsh/.zshrc"

_info "Copying file to $HOME ..."

cp -p "$_file" $HOME && _ok "Copied $_file to $HOME"
