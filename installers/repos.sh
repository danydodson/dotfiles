#!/usr/bin/env bash

# Clones github repos

. "$HOME/.dotfiles/ansi/feedback.sh"

set -e
trap on_error SIGTERM

REPOS=$HOME/Developer/github

install_repos() {
  if [ ! -d "$REPOS" ]; then
    info "Creating dir $REPOS..."
    mkdir -p "$REPOS"
  fi

  GH_USER=danydodson

  cd "$REPOS"
  info "Getting $GH_USER's github repos..."
  curl "https://api.github.com/users/$GH_USER/repos?page=1&per_page=30" | grep -F 'clone_url' | cut -d \" -f 4 | xargs -L1 git clone --recursive
  curl "https://api.github.com/users/$GH_USER/repos?page=2&per_page=30" | grep -F 'clone_url' | cut -d \" -f 4 | xargs -L1 git clone --recursive
  curl "https://api.github.com/users/$GH_USER/repos?page=3&per_page=30" | grep -F 'clone_url' | cut -d \" -f 4 | xargs -L1 git clone --recursive
  curl "https://api.github.com/users/$GH_USER/repos?page=4&per_page=30" | grep -F 'clone_url' | cut -d \" -f 4 | xargs -L1 git clone --recursive
  curl "https://api.github.com/users/$GH_USER/repos?page=5&per_page=30" | grep -F 'clone_url' | cut -d \" -f 4 | xargs -L1 git clone --recursive
  curl "https://api.github.com/users/$GH_USER/repos?page=6&per_page=30" | grep -F 'clone_url' | cut -d \" -f 4 | xargs -L1 git clone --recursive
}

main() {
  install_repos "$"
}

main "$*"
