#!/bin/bash

# Installs yazi plugins

. "$HOME/.dotfiles/bin/reports"

set -e
trap on_error SIGTERM

setup_ssh() {
  info "Setting ssh permissions..."

  if [ ! -d "$HOME/.ssh" ]; then
    mkdir -p ~/.ssh && chmod 700 ~/.ssh
  fi
  if [ ! -f ~/.ssh/known_hosts ]; then
    touch ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
  fi
  if [ ! -f ~/.ssh/authorized_keys ]; then
    touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
  fi
}

main() {
  setup_ssh "$"
}

main "$*"
