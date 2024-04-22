#!/usr/bin/env bash

# path
path-prepend "$DOTFILES/bin"
path-prepend "$HOME/.config/bun/bin"
path-prepend "$HOME/.config/pyenv/shims"
path-prepend "$HOME/.config/local/share/pnpm"
path-prepend "/opt/homebrew/opt/openssl@3/bin"

# fpath
fpath-prepend "/opt/homebrew/share/zsh/site-functions"
fpath-prepend "/opt/homebrew/share/zsh/zsh-completions"
