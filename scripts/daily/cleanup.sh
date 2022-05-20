#!/bin/bash

# Script cleaning up tmp files

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }

__info "Cleaning up brew packages"
brew bundle dump
brew bundle --force cleanup
brew cleanup -v
rm Brewfile

__info "Cleaning up ruby gems"
gem cleanup -v

__info "Deleting .DS_Store files"
find . -type f -name '*.DS_Store' -ls -delete
