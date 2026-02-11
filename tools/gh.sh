#!/bin/bash

# Sets up gh cli tool.

. "$HOME/.dotfiles/bin/reports"

set -e
trap on_error SIGTERM

function setup_gh_tool() {
  if exists gh; then
    info "Setting up gh..."

    if [ ! -f ~/.config/git/.secret ]; then
      touch ~/.config/git/.secret
    fi

    gh auth login

    # gh auth refresh -h github.com -s admin:public_key
    # gh auth refresh -h github.com -s admin:ssh_signing_key
    # gh auth refresh -s read:gpg_key

    echo
  else
    error "Error: gh is not available"
  fi
}

main() {
  setup_gh_tool "$*"
}

main "$*"
