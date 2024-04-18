#!/usr/bin/env bash

# Clean temporary files

echo ' > Removing node_modules...'
find ~/Developer -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;

echo ' > Removing completion dumps...'
find ~/.config/cache/zsh ! -name 'zsh_history' -type f -exec rm -f {} +

echo ' > Removing zcompdumps...'
rm -rfv ~/.config/zsh/.zcompdump*

echo ' > Emptying Trash...'
sudo rm -rfv ~/.Trash
