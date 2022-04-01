# #!/bin/bash

# set -e

# if [ -f "${HOME}"/Library/Preferences/com.googlecode.iterm2.plist ] || true; then
#   echo "> Coppied to ~/Library/Preferences/com.googlecode.iterm."
#   cp -s ~/.dotfiles/specific/iterm/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist
# fi

export ITERM2_CONFIG=require'~/.config/iterm2'

if [ -f "${ITERM2_CONFIG}"/iterm2_shell_integration.zsh ]; then
  echo "> Fetching utilities now."
  curl -L https://iterm2.com/shell_integration/zsh -o "${ITERM2_CONFIG}"/iterm2_shell_integration.zsh
fi
