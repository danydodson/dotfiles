#!/bin/bash

# Log Helpers
. "$HOME/Developer/Dotfiles/utils/helpers.sh"
. "$HOME/Developer/Dotfiles/utils/pretty.bash"

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Mac App Store                                                               #
###############################################################################
__info 'Uninstalling macos apps...'

sudo mas uninstall 409203825 || __err 'failed to uninstall Numbers'
sudo mas uninstall 408981434 || __err 'failed to uninstall iMovie'
sudo mas uninstall 409183694 || __err 'failed to uninstall Keynote'
sudo mas uninstall 682658836 || __err 'failed to uninstall Garageband'
sudo mas uninstall 409201541 || __err 'failed to uninstall Pages'
