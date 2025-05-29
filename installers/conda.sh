#!/usr/bin/env bash

# Installs pyenv, python, and pips

# shellcheck disable=SC1091
. "$HOME/.dotfiles/tools/reports.sh"

set -e
trap on_error SIGTERM

install_miniconda() {

    mkdir -p ~/.config/miniconda3

    curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/.config/miniconda3/miniconda.sh

    bash ~/.config/miniconda3/miniconda.sh -b -u -p ~/.config/miniconda3
    
    rm ~/.config/miniconda3/miniconda.sh
}

main() {
    install_miniconda "$*"
    on_finish "$*"
}

main "$*"
