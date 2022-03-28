#!/bin/bash
# 
# update os
# 

# Mac App Store update
softwareupdate -i -a

# shellcheck disable=SC1091
source "${DOTFILES}"/specific/macos/set-defaults.sh
