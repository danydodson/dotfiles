#!/usr/bin/env bash

# Analyse all shell scripts with ShellCheck

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }

__info 'Analysing all shell scripts with ShellCheck..'

for script in $(rg -t sh -T zsh --files "$DOTFILES"); do
  shellcheck "$script" && __ok "$script"
done
