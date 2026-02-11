#!/bin/bash

# Installs nvim

. "$HOME/.dotfiles/bin/reports"

set -e
trap on_error SIGTERM

sudo -v

while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

setup_nvim() {
  install_nvim_release
  install_nvim_configs

  finish
}

install_nvim_release() {
  if ! which nvim >/dev/null 2>&1; then
    if [ ! -f /usr/local/bin/nvim ]; then
      info "Installing nvim-macos-arm64..."
      target=nvim-macos-arm64
      filename="$target.tar.gz"
      downloads="$HOME/Downloads"

      info "download https://github.com/neovim/neovim/releases/latest/download/$filename..."
      wget -q -P "$downloads" "https://github.com/neovim/neovim/releases/latest/download/$filename"

      info 'removing quarintine...'
      xattr -c "$downloads/$filename"

      # unzip
      info "unraring $downloads/$filename..."
      tar -xzf "$downloads/$filename"

      info 'moving nvim file to system locations...'
      sudo mv "$target/bin/nvim" /usr/local/bin/
      sudo mv "$target/lib" /usr/local/lib/
      sudo mv "$target/share" /usr/local/share/

      info 'cleaning up files...'
      rm -rf "${downloads:?}/${target}"
      rm "$downloads"/$filename
    fi
  fi

  info 'skipped installing nvim...'

  finish
}

install_nvim_configs() {
  if [ ! -d "$HOME/.config/nvim" ]; then
    info 'cloning github.com/danydodson/nvim to ~/.config/nvim'
    git clone https://github.com/danydodson/nvim "$HOME/.config/nvim"

  fi

  info 'skipped installing nvim configs...'
}

main() {
  setup_nvim "$"
}

main "$*"
