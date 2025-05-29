#!/usr/bin/env bash

# Installs oh-my-zsh

# shellcheck disable=SC1091
. "$HOME/.dotfiles/tools/reports.sh"

set -e
trap on_error SIGTERM

setup_ohmyzsh() {
    install_sketchybar
    finish
}

install_ohmyzsh() {
    info "installing ohmyzsh..."
}

main() {
    setup_ohmyzsh "$"
    on_finish "$*"
}

main "$*"
