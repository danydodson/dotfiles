#!/bin/bash

# Change scripts with 644 permissions to 755 permissions

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }

dots="$HOME/Developer/Dotfiles"
bin="$HOME/Developer/Dotfiles/config/bin"

__info "Changing scripts with 644 permissions to 755 permissions..."

for script in $(rg -t sh -T zsh --files "$dots"); do
  [[ $(stat -f "%OLp" "$script") == '644' ]] && chmod +x "$script" && __ok "$script"
done

for script in $(rg --files "$bin"); do
  [[ $(stat -f "%OLp" "$script") == '644' ]] && chmod +x "$script" && __ok "$script"
done

exit 0
