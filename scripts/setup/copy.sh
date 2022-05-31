#!/usr/bin/env bash

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }

__info "Copying some dotfiles to $HOME ..."

aws="${DOTFILES}/config/aws"
cp -r "$aws" "$HOME/.config/" && __ok "Copied $aws"

bat="$DOTFILES/config/bat"
cp -r "$bat" "$HOME/.config/" && __ok "Copied $bat"

gitcon="$DOTFILES/config/git/dot.gitconfig"
cp -r "$gitcon" "$HOME/.config/git/config" && __ok "Copied $gitcon"

neofetch="$DOTFILES/config/neofetch"
cp -r "$neofetch" "$HOME/.config/" && __ok "Copied $neofetch"

readline="$DOTFILES/config/readline"
cp -r "$readline" "$HOME/.config/" && __ok "Copied $readline"

ranger="$DOTFILES/config/ranger"
cp -r "$ranger" "$HOME/.config/" && __ok "Copied $ranger"

vim="$DOTFILES/config/vim"
cp -r "$vim" "$HOME/.config/" && __ok "Copied $vim to $HOME"

zshrc="$DOTFILES/zsh/.zshrc"
cp -p "$zshrc" "$HOME" && __ok "Copied $zshrc"
cp -p "$zshrc" "$HOME/.config/zsh/" && __ok "Copied $zshrc again"
