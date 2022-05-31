#!/usr/bin/env bash

# Removes tmp files

__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }

__info 'Removes DS_Stores'
find . -name '*.DS_Store' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;

__info 'Removes node_modules'
find ~/Documents/Developer -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;

# __info 'Removes logs'
# sudo rm -rfv /private/var/log/asl/*.asl

# __info 'Removes compdump'
rm -rfv ~/.config/zsh/.zcompdump*

__info 'Removes Trash'
sudo rm -rfv /Volumes/*/.Trashes
sudo rm -rfv ~/Library/'Mobile\ Documents'/com~apple~CloudDocs/.Trash
sudo rm -rfv ~/.Trash
