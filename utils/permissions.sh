#!/bin/bash

# Change scripts with 644 permissions to 755 permissions

# Log Helpers
. "$HOME/Developer/Dotfiles/utils/helpers.sh"
. "$HOME/Developer/Dotfiles/utils/pretty.bash"

_DOTFILES="$HOME/Dotfiles"

_info "Changing scripts with 644 permissions to 755 permissions..."

for script in $(rg -t sh -T zsh --files "$_DOTFILES"); do
  [[ $(stat -f "%OLp" "$script") == '644' ]] && chmod +x "$script" && _ok "$script"
done

