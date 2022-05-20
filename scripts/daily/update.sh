#!/bin/bash

# Script updating software packages

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }

__info "Updating oh-my-zsh..."
"$HOME"/.config/local/share/oh-my-zsh/tools/upgrade.sh

__info "Updating homebrew..."
brew update
brew upgrade
brew autoremove
brew cleanup --prune=all -s

__info "Upgrading App Store apps..."
mas outdated
mas upgrade

# __info "Updating npm packages"
# npm update -g
