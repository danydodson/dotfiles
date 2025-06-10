#!/usr/bin/env bash

# Clones github repos

# shellcheck disable=SC1091
. "$HOME/.dotfiles/tools/reports.sh"

set -e
trap on_error SIGTERM

install_repos() {
    if [ ! -d "$HOME/Developer/repos" ]; then
        info 'Creating dir ~/Developer/repos...'
        mkdir -p "$HOME/Developer/repos"
    fi

    GH_USER=danydodson
    PAGE=1

    cd ~/Developer/repos
    info "Getting $GH_USER's github repos..."
    curl "https://api.github.com/users/$GH_USER/repos?page=$PAGE&per_page=5" | grep -F 'clone_url' | cut -d \" -f 4 | xargs -L1 git clone --recursive

    finish
}

main() {
    install_repos "$"
}

main "$*"
