#!/bin/bash

# Script updating software packages

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }

__info "Updating oh-my-zsh"
omz update

__info "Updating homebrew and packages"
brew update
brew upgrade

__info "Upgrading App Store apps"
mas outdated
mas upgrade

__info "Updating npm packages"
npm update -g

__info "Updating ruby gems"
gem update
