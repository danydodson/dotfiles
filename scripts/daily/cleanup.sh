#!/bin/bash

# Script cleaning up tmp files

# Log Helpers
# . "$HOME/Developer/Dotfiles/utils/helpers.sh"
. "$HOME/Developer/Dotfiles/utils/pretty.bash"

__info "Cleaning up brew packages"
brew bundle dump
brew bundle --force cleanup
brew cleanup -v
rm Brewfile

__info "Cleaning up ruby gems"
gem cleanup -v

__info "Deleting .DS_Store files"
find . -type f -name '*.DS_Store' -ls -delete
