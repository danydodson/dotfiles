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
  fi

  if [ -d "$HOME/.config/miniconda3" ]; then
    source "$HOME/.config/miniconda3/etc/profile.d/conda.sh"

    if ! conda env list | grep -q "^myenv "; then
      info "conda create myenv env 3.13.5 in miniconda..."
      conda create -y -n myenv python=3.13.5
    else
      info "conda myenv environment already exists, skipping creation..."

      info "conda activate myenv environment..."
      conda activate myenv

      info "conda install packages in myenv environment..."
      # conda install -c apple tensorflow-deps
      # conda install -c conda-forge pybind11
      for pkg in matplotlib jupyterlab seaborn opencv joblib pytables; do
        if conda list "$pkg" | grep -q "^$pkg"; then
          info "conda package '$pkg' already installed, skipping..."
        else
          conda install -y "$pkg"
        fi
      done

      if pip show "debugpy" >/dev/null 2>&1; then
        info "pip package 'debugpy' already installed, skipping..."
      else
        pip install "debugpy"
      fi

    fi
  else
    info "miniconda3 not found in ~/.config/miniconda3. Skipping conda environment setup..."
  fi
}

main() {
  install_miniconda "$*"
}

main "$*"
