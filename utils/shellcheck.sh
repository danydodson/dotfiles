#!/bin/bash

# Analyse all shell scripts with ShellCheck

# Log Helpers
. "$HOME/Developer/Dotfiles/utils/helpers.sh"
. "$HOME/Developer/Dotfiles/utils/pretty.bash"

DOTFILES="${HOME}/Developer/Dotfiles"

__info 'Analysing all shell scripts with ShellCheck..'

for script in $(rg -t sh -T zsh --files "$DOTFILES"); do
  shellcheck -e SC1091 "$script" && __ok "$script"
done
