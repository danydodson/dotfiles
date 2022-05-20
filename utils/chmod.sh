#!/bin/bash

# Change scripts with 644 permissions to 755 permissions

DOTFILES="$HOME/Developer/Dotfiles"

# Log Helpers
. "$DOTFILES/utils/helpers.sh"
. "$DOTFILES/utils/pretty.bash"

__info "Changing scripts with 644 permissions to 755 permissions..."

for script in $(rg -t sh -T zsh --files "$DOTFILES"); do
  [[ $(stat -f "%OLp" "$script") == '644' ]] && chmod +x "$script" && __ok "$script"
done
