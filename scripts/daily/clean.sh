#!/usr/bin/env bash

# Removes tmp files

__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }

__info 'Removing DS_Stores...'
find . -name '*.DS_Store' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;

# __info 'Removing node_modules...'
find ~/Documents/Developer/Current -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;
find ~/Documents/Developer/Github -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;
find ~/Documents/Developer/Scripts -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;
find ~/Documents/Developer/Security -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;
find ~/Documents/Developer/Served -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;

__info 'Removing zcompdump...'
rm -rfv ~/.config/zsh/.zcompdump*
rm -rfv ~/.config/zsh/.z

__info 'Removing Trash...'
sudo rm -rfv /Volumes/*/.Trashes
sudo rm -rf ~/Library/Mobile\ Documents/com~apple~CloudDocs/.Trash
sudo rm -rfv ~/.Trash
