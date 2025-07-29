#!/usr/bin/env bash

# Installs nvm, node lts, and global packages

. "$HOME/.dotfiles/reports/pretty-dots.sh"

set -e
trap on_error SIGTERM

[[ -f "/opt/homebrew/opt/nvm/nvm.sh" ]] && . "/opt/homebrew/opt/nvm/nvm.sh"

function install_node_with_nvm() {
    if exists nvm; then
        read -rp "Do you want to install node using nvm yet? [y/N] " -n 1 answer
        echo
        if [ "${answer}" != "y" ]; then
            return
        fi
        echo
        info "Installing node with nvm..."
        nvm install v22.11.0
        nvm use v22.11.0
        nvm install-latest-npm
        echo
    else
        error "Error: nvm is not available"
    fi
    
    finish
}

function install_npm_deps() {
    if exists npm; then
        read -rp "Do you want to install npm global packages yet? [y/N] " -n 1 answer
        echo
        if [ "${answer}" != "y" ]; then
            return
        fi
        echo
        info "Installing npm global packages..."
        npm install -g bash-handbook
        npm install -g nodemon
        echo
    else
        error "Error: npm is not available"
    fi
    finish
}

main() {
    install_node_with_nvm "$*"
    install_npm_deps "$*"
}

main "$*"
