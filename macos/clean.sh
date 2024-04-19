#!/usr/bin/env bash

# Update and clean

echo ' > Software update...'
sudo softwareupdate -i -a

echo ' > Upgrading oh-my-zsh...'
"$ZSH/tools/upgrade.sh"

echo ' > Upgrading global npm...'
npm update --location=global

echo ' > Upgrading homebrew...'
brew update && brew upgrade && brew autoremove && brew cleanup --prune=all -s

echo ' > Removing node_modules...'
find ~/Developer -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;

echo ' > Removing completion dumps...'
find ~/.config/cache/zsh ! -name 'zsh_history' -type f -exec rm -f {} +

echo ' > Removing zcompdumps...'
rm -rfv ~/.config/zsh/.zcompdump*

echo ' > Emptying Trash...'
sudo rm -rfv ~/.Trash
