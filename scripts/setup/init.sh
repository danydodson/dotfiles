#!/usr/bin/env bash

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

__info 'Updating OSX.  If this requires a restart, run the setup.sh script again.'

__info 'Installing all available updates...'
sudo softwareupdate -ia --verbose && __ok 'installed all software updates'

__info 'Checking if xcode is installed...'
if test ! "$(xcode-select -p)"; then
  xcode-select --install && __ok 'installed Xcode Command Line Tools'
else
  __ok 'already installed'
fi

__info 'Checking for homebrew...'
if test ! "$(which brew)"; then
  __info '> Installing Homebrew'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && __ok 'installed Homebrew'
else
  __ok 'Homebrew is already installed'
fi

# ============================================================================
# plist
# ============================================================================

# _bootstrap_plist() {
#   dotfiles_plist="${HOME}/Library/LaunchAgents/dotfiles.plist"
#   [ ! -f "$(readlink "$dotfiles_plist")" ] && {
#     __dko_err "dotfiles.plist not symlinked. Run bootstrap/symlink!"
#     return 1
#   }

#   __dko_status "Reloading dotfiles.plist"
#   launchctl unload "$dotfiles_plist" 2>/dev/null
#   launchctl load "$dotfiles_plist"
# }
# _bootstrap_plist || exit 1