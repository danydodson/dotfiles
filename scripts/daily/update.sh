#!/bin/bash

# Script updating software packages

echo ''

# Log Helper
_info() { echo -e "\033[1m[INFO]\033[0m $1"; }

_info "Updating oh-my-zsh"
omz update

_info "Updating homebrew and packages"
brew update
brew upgrade

_info "Upgrading App Store apps"
mas outdated
mas upgrade

_info "Updating npm packages"
npm update -g

_info "Updating ruby gems"
gem update
