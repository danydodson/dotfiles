#!/bin/bash

# Installs tmux and plugins

. "$HOME/.dotfiles/bin/reports"

set -e
trap on_error SIGTERM

install_tmux() {
  case $(uname) in
  Darwin)
    if ! which tmux >/dev/null 2>&1; then
      info "Install tmux via Brewfile on macOS."
    fi
    install_tmux_plugins
    ;;
  Linux)
    if ! which tmux >/dev/null 2>&1; then
      info "Install tmux ßvia Brewfile on linux."
    fi
    install_tmux_plugins
    ;;
  *) ;;
  esac
}

install_tmux_plugins() {
  if [ ! -d "$HOME"/.config/tmux/plugins ]; then
    info 'Creating dir ~/.config/tmux/plugins...'
    mkdir -p "$HOME"/.config/tmux/plugins
  fi

  if [ ! -d "$HOME/.config/tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
  fi
  if [ ! -d "$HOME/.config/tmux/plugins/tmux-1password" ]; then
    git clone https://github.com/yardnsm/tmux-1password "$HOME/.config/tmux/plugins/tmux-1password"
  fi
  if [ ! -d "$HOME/.config/tmux/plugins/tmux-sensible" ]; then
    git clone https://github.com/tmux-plugins/tmux-sensible "$HOME/.config/tmux/plugins/tmux-sensible"
  fi
  if [ ! -d "$HOME/.config/tmux/plugins/tmux-continuum" ]; then
    git clone https://github.com/tmux-plugins/tmux-continuum "$HOME/.config/tmux/plugins/tmux-continuum"
  fi
  if [ ! -d "$HOME/.config/tmux/plugins/tmux-resurrect" ]; then
    git clone https://github.com/tmux-plugins/tmux-resurrect "$HOME/.config/tmux/plugins/tmux-resurrect"
  fi
  if [ ! -d "$HOME/.config/tmux/plugins/vim-tmux-navigator" ]; then
    git clone https://github.com/christoomey/vim-tmux-navigator "$HOME/.config/tmux/plugins/vim-tmux-navigator"
  fi
  if [ ! -d "$HOME/.config/tmux/plugins/better-vim-tmux-resizer" ]; then
    git clone https://github.com/RyanMillerC/better-vim-tmux-resizer "$HOME/.config/tmux/plugins/better-vim-tmux-resizer"
  fi
  if [ ! -d "$HOME/.config/tmux/plugins/minimal-tmux-status" ]; then
    git clone https://github.com/niksingh710/minimal-tmux-status "$HOME/.config/tmux/plugins/minimal-tmux-status"
  fi

  info "to finish the installation, install all plugins with <prefix> + I in tmux."
}

main() {
  install_tmux "$"
}

main "$*"
