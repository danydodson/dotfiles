#!/usr/bin/env bash

# Update all the things

# shellcheck disable=SC1091
. "${DOTFILES}/macos/pretty.sh"

__info_ ' ➡ Updating macos apps...'
sudo softwareupdate -i -a

__info_ ' ➡ Upgrading oh-my-zsh...'
"$ZSH/tools/upgrade.sh"

__info_ ' ➡ Updating npm global pkgs...'
npm update --location=global

__info_ ' ➡ Upgrading yarn global pkgs...'
yarn global upgrade

__info_ ' ➡ Upgrading homebrew...'
brew update && brew upgrade && brew autoremove && brew cleanup --prune=all -s

__info_ ' ➡ Removing node_modules...'
find . -name "node_modules" -type d -prune -exec rm -vrf '{}' +
