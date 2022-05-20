#!/bin/bash

# Analyse all shell scripts with ShellCheck

# Log Helpers
. "$HOME/Developer/Dotfiles/utils/helpers.sh"
. "$HOME/Developer/Dotfiles/utils/pretty.bash"

__dotfiles="$HOME/Developer/Dotfiles"

__info 'Analysing all shell scripts with ShellCheck..'

for script in $(rg -t sh -T zsh --files "$__dotfiles"); do
  shellcheck --exclude=SC1091 "$script" && __ok "$script"
done
