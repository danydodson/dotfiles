#!/bin/bash

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }

__info "Copying some dotfiles to $HOME ..."

_zshrc="$DOTFILES/zsh/.zshrc"
cp -p "$_zshrc" "$HOME" && __ok "Copied $_zshrc to $HOME/.zshrc"
cp -p "$_zshrc" "$HOME/.config/zsh" && __ok "Copied $_zshrc to $HOME/.config/zsh/.zshrc"

_bat="$DOTFILES/config/bat/"
cp -r "$_bat" "$HOME/.config/bat" && __ok "Copied $_bat to $HOME"

_neofetch="$DOTFILES/config/neofetch/"
cp -r "$_neofetch" "$HOME/.config/neofetch" && __ok "Copied $_neofetch to $HOME"

_ranger="$DOTFILES/config/ranger/"
cp -r "$_ranger" "$HOME/.config/ranger" && __ok "Copied $_ranger to $HOME"

_vim="$DOTFILES/config/vim/"
cp -r "$_vim" "$HOME/.config/vim" && __ok "Copied $_vim to $HOME"
