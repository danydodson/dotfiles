#!/bin/bash

# Script cleaning up tmp files

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }

__info "Cleaning up brew packages..."
brew bundle dump
brew bundle --force cleanup
brew cleanup -v
rm Brewfile

__info "Deleting **/.DS_Store files..."
find . -type f -name '*.DS_Store' -ls -delete

__info "Deleting ~/Developer/**/node_modules folders..."
find ~/Developer -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;
