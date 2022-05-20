#!/bin/bash

# Script updating software packages

# Log Helpers
# . "$HOME/Developer/Dotfiles/utils/helpers.sh"
. "$HOME/Developer/Dotfiles/utils/pretty.bash"

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
