#!/bin/bash

# Analyse all shell scripts with ShellCheck

# Log Helpers
. "$HOME/Developer/Dotfiles/utilities/helpers.sh"
. "$HOME/Developer/Dotfiles/utilities/pretty.bash"

_dotfiles="$HOME/Developer/Dotfiles"

__info 'Analysing all shell scripts with ShellCheck..'

for script in $(rg -t sh -T zsh --files "$_dotfiles"); do
  shellcheck --exclude=SC1091 "$script" && __ok "$script"
done
