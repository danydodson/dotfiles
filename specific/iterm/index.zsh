#!/bin/bash
#
# Homebrew
#

# check for homebrew
if test ! "$(command -v brew)" || true; then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || true
fi

# run homebrew through the brewfile
echo "> brew bundle"
brew bundle --file="specific/brew/Brewfile"

exit 0
