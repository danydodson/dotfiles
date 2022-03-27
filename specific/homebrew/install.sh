#!/bin/bash

# Homebrew

# Check for Homebrew
if test ! "$(command -v brew)"; then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Run Homebrew through the Brewfile
echo "> brew bundle"
brew bundle --file="specific/homebrew/Brewfile"

exit 0
