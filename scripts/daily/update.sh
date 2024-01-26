#!/usr/bin/env bash

# Script updating software packages

__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }

__info 'Software update...'
sudo softwareupdate -i -a

__info 'Upgrading oh-my-zsh...'
"$ZSH/tools/upgrade.sh"

__info 'Upgrading global npm...'
npm update --location=global

__info 'Upgrading global yarn...'
cd "$HOME/.config/local/share/yarn/global" && yarn global upgrade

__info 'Upgrading homebrew...'
brew update && brew upgrade && brew autoremove && brew cleanup --prune=all -s
