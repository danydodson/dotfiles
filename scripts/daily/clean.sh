#!/usr/bin/env bash

# Removes tmp files

__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }

# __info 'Removing node_modules...'
# find ~/Developer -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;

__info 'Removing zcompdump...'
rm -rfv ~/.config/zsh/.zcompdump*
rm -rfv ~/.config/zsh/.z

__info 'Removing Trash...'
sudo rm -rfv /Volumes/*/.Trashes
sudo rm -rf ~/Library/Mobile\ Documents/com~apple~CloudDocs/.Trash
sudo rm -rfv ~/.Trash
