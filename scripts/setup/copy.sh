#!/usr/bin/env bash

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }

__info "Copying some dotfiles to $HOME ..."

_DOTFILES="$HOME/.dotfiles"

ack="${_DOTFILES}/config/ack"
cp -r "$ack" "$HOME/.config/" && __ok "Copied $ack"

bat="$_DOTFILES/config/bat"
cp -r "$bat" "$HOME/.config/" && __ok "Copied $bat"

curl="$_DOTFILES/config/curl"
cp -r "$curl" "$HOME/.config/" && __ok "Copied $curl"

gitconf="$_DOTFILES/config/git/dot.gitconfig"
mkdir -p "$HOME/.config/git"
cp -r "$gitconf" "$HOME/.config/git/config" && __ok "Copied $gitconf"

neofetch="$_DOTFILES/config/neofetch"
cp -r "$neofetch" "$HOME/.config/" && __ok "Copied $neofetch"

npm="$_DOTFILES/config/npm"
cp -r "$npm" "$HOME/.config/" && __ok "Copied $npm"

python="$_DOTFILES/config/python"
cp -r "$python" "$HOME/.config/" && __ok "Copied $python"

ranger="$_DOTFILES/config/ranger"
cp -r "$ranger" "$HOME/.config/" && __ok "Copied $ranger"

vim="$_DOTFILES/config/vim"
cp -r "$vim" "$HOME/.config/" && __ok "Copied $vim to $vim"

wget="$_DOTFILES/config/wget"
cp -r "$wget" "$HOME/.config/" && __ok "Copied $wget to $wget"

xcode="$_DOTFILES/config/xcode"
themedir="$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes"
mkdir -p "$themedir"
cp -r "$xcode" "$themedir" && __ok "Copied $xcode to $themedir"

zshrc="$_DOTFILES/zsh/.zshrc"
mkdir -p "$HOME/.config/zsh"
cp -p "$zshrc" "$HOME" && __ok "Copied $zshrc"
cp -p "$zshrc" "$HOME/.config/zsh/" && __ok "Copied $zshrc again"
