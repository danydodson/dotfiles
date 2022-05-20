#!/bin/bash
# shellcheck disable=SC2015

# Clone github repositories to local machine

# Log Helpers
. "$HOME/Developer/Dotfiles/utilities/helpers.sh"
. "$HOME/Developer/Dotfiles/utilities/pretty.bash"

__info "Cloning repositories..."

# Served sites
SERVED=$HOME/Developer/Served

git clone git@github.com:danydodson/danydodson-dev.git "$SERVED"/danydodson-dev && __ok '' || __err "Failed to clone danydodson-dev"
