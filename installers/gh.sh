#!/usr/bin/env bash

# Sets up gh cli tool.

# shellcheck disable=SC1091
. "$HOME/.dotfiles/tools/reports.sh"

set -e
trap on_error SIGTERM

function setup_gh_tool() {
    if exists gh; then
        info "Setting up gh..."

        if [ ! -f ~/.dotfiles/.gitsecret ]; then
            touch ~/.dotfiles/.gitsecret
        fi

        gh auth login

        # gh auth refresh -h github.com -s admin:public_key
        # gh auth refresh -h github.com -s admin:ssh_signing_key
        # gh auth refresh -s read:gpg_key

        echo
    else
        error "Error: gh is not available"
    fi
    
    finish
}

main() {
    setup_gh_tool "$*"
    on_finish "$*"
}

main "$*"
