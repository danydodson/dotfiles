#!/bin/bash

# Clone github repositories to local machine

# Log Helpers
. "$HOME/Developer/Dotfiles/utils/helpers.sh"
. "$HOME/Developer/Dotfiles/utils/pretty.bash"

__info "Cloning repositories..."

# Served sites
__served=$HOME/Developer/Served

git clone git@github.com:danydodson/danydodson-dev.git "$__served"/danydodson-dev && __ok ''
