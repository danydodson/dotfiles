#!/bin/bash

# Change scripts with 644 permissions to 755 permissions

# Log Helper
_info() { echo -e "\033[36m[INFO]\033[0m $1"; }
_ok() { echo -e "\033[32m[OK]\033[0m $1"; }

_DOTFILES="$HOME/Dotfiles"

_info "Changing scripts with 644 permissions to 755 permissions..."

for script in $(rg -t sh -T zsh --files "$_DOTFILES"); do
  [[ $(stat -f "%OLp" "$script") == '644' ]] && chmod +x "$script" && _ok "$script"
done

