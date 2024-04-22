#!/usr/bin/env bash

# Update all the things

# shellcheck disable=SC1091
. "${DOTFILES}/macos/pretty.sh"

echo ' > Updating macos apps...'
sudo softwareupdate -i -a

echo ' > Upgrading oh-my-zsh...'
"$ZSH/tools/upgrade.sh"

echo ' > Updating npm global pkgs...'
npm update --location=global

echo ' > Upgrading yarn global pkgs...'
yarn global upgrade

echo ' > Upgrading homebrew...'
brew update && brew upgrade && brew autoremove && brew cleanup --prune=all -s

echo ' > Removing node_modules...'
find ~/Developer -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;
