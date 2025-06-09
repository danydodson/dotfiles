#!/usr/bin/env bash

# Installs pyenv, python, and pips

# shellcheck disable=SC1091
. "$HOME/.dotfiles/tools/reports.sh"

set -e
trap on_error SIGTERM

install_miniconda() {
    if [ ! -d "$HOME/.config/miniconda3" ]; then

        info "creating ~/.config/miniconda3..."
        mkdir -p ~/.config/miniconda3

        info "downloading Miniconda3-latest-MacOSX-arm64.sh..."
        curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/.config/miniconda3/miniconda.sh

        info "running miniconda.sh..."
        bash ~/.config/miniconda3/miniconda.sh -b -u -p ~/.config/miniconda3

        info "removing miniconda.sh..."
        rm ~/.config/miniconda3/miniconda.sh

        echo
    fi

    finish
}

main() {
    install_miniconda "$*"
    on_finish "$*"
}

main "$*"
