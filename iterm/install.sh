#!/usr/bin/env bash

# if [ -f "${HOME}"/Library/Preferences/com.googlecode.iterm2.plist ] || true; then
#   echo "> Coppied to ~/Library/Preferences/com.googlecode.iterm."
#   rm -rf ~/Library/Preferences/com.googlecode.iterm2.plist
#   cp ~/.dotfiles/iterm/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
# fi

export ITERM2_CONFIG=~/.config/iterm2/iterm2_shell_integration.zsh

if [ ! -f $ITERM2_CONFIG ]; then
  echo "> Fetching utilities now."
  curl -L https://iterm2.com/shell_integration/zsh -o "${HOME}/.config/iterm2/iterm2_shell_integration.zsh"
fi
