#!/bin/bash

# Analyse all shell scripts with ShellCheck

DOTFILES="$HOME"/Developer/Dotfiles

# . "$DOTFILES"/utils/helpers.sh
. "$DOTFILES"/utils/pretty.bash

__info 'Analysing all shell scripts with ShellCheck..'

for script in $(rg -t sh -T zsh --files "$DOTFILES"); do
  shellcheck -e SC1091 "$script" && __ok "$script"
done
