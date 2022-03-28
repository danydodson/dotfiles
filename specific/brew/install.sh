#!/bin/bash
# 
# Homebrew
# 

# hides hints in cli
# export HOMEBREW_NO_ENV_HINTS=false

# check for homebrew
if test ! "$(command -v brew)"; then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# run homebrew through the brewfile
echo "> brew bundle"
brew bundle --file="specific/brew/Brewfile"

exit 0
