#!/usr/bin/env bash

# Abort on error
set -e

echo "Checking if Homebrew is already installed..."

# Checks if Homebrew is installed
# Credit: https://gist.github.com/codeinthehole/26b37efa67041e1307db
if test ! $(which brew); then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed..."
fi

# run homebrew through the brewfile
echo "> brew bundle"

brew bundle --file="brew/Brewfile"

exit 0
