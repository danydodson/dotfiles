#!/bin/bash
#
# Homebrew
#

# hides hints in cli
# export HOMEBREW_NO_ENV_HINTS=false

# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || true
# check for homebrew
include_recipe 'homebrew'
if test ! "$(command -v brew)"; then
  echo "  Installing Homebrew for you."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# run homebrew through the brewfile
echo "> brew bundle"
brew bundle --file="specific/brew/Brewfile"

exit 0
