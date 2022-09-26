#!/usr/bin/env bash

# Script updating software packages

__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }

__info 'Upgrading software packages...'

__info 'app store...'
mas outdated
mas upgrade

__info 'oh-my-zsh...'
/Users/Dany/.config/local/share/oh-my-zsh/tools/upgrade.sh

# __info 'global npm...'
# npm update -g

__info 'global yarn...'
cd /Users/Dany/.config/local/share/yarn/global && yarn global upgrade

# __info 'homebrew...'
# brew bundle dump
# brew bundle --force cleanup
# brew cleanup -v
# rm Brewfile
