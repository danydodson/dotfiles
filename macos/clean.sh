#!/usr/bin/env bash
# vim:syntax=zsh
# vim:filetype=zsh

# Update all the things

# shellcheck disable=SC1091
. "${DOTFILES}/macos/pretty.sh"

__info ' > Updating macos apps...'
sudo softwareupdate -i -a

__info ' > Upgrading oh-my-zsh...'
"$ZSH/tools/upgrade.sh"

__info ' > Updating npm global pkgs...'
npm update --location=global

__info ' > Upgrading yarn global pkgs...'
yarn global upgrade

__info ' > Upgrading homebrew...'
brew update && brew upgrade && brew autoremove && brew cleanup --prune=all -s

__info ' > Removing node_modules...'
find ~/Developer -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;

__info ' > Removing logs...'
sudo rm -rf /private/var/log/asl/*.asl