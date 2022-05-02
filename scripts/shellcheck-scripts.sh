#!/bin/bash

# Analyse all shell scripts with ShellCheck

# Log Helper
_info() { echo -e "\033[36m[INFO]\033[0m $1"; }

_DOTFILES="$HOME/Dotfiles"

_info 'Analysing all shell scripts with ShellCheck..'

for script in $(rg -t sh -T zsh --files "$_DOTFILES"); do
  shellcheck "$script"
done
