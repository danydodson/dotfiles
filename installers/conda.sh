#!/usr/bin/env bash

# Installs pyenv, python, and pips

. "$HOME/.dotfiles/reports/feedback.sh"

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

        source $HOME/.zshrc

        # python packages (mainly for data science)
        conda install -c apple tensorflow-deps
        conda install -c conda-forge pybind11
        conda install matplotlib
        conda install jupyterlab
        conda install seaborn
        conda install opencv
        conda install joblib
        conda install pytables

        pip install tensorflow-macos
        pip install tensorflow-metal
        pip install debugpy
        pip install sklearn

        echo
    fi
}

main() {
    install_miniconda "$*"
}

main "$*"
