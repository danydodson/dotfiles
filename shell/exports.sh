#!/bin/bash

# editor
export EDITOR="nvim"
export VISUAL="nvim"

# dotfiles
export DOTFILES="$HOME/.dotfiles"

# xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# zsh, omz
export ZSH="${HOME}/.config/omz"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"
export ZSH_CUSTOM="${XDG_CONFIG_HOME}/omz/custom"

# homebrew
export HOMEBREW_BUNDLE_FILE_GLOBAL="$DOTFILES/macos/brewfile"

# go
export GOPATH="$XDG_CONFIG_HOME/go"
export GOROOT="/opt/homebrew/opt/go/libexec"

# rust
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export RUSTUP_HOME="$XDG_CONFIG_HOME/rust"

# npm, deno, yarn, pnpm, bun,
export BUN_INSTALL="$XDG_CONFIG_HOME/bun"
# export PNPM_HOME="$XDG_DATA_HOME/pnpm"
# export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export DENO_INSTALL="$XDG_CONFIG_HOME/deno"
# export YARN_CACHE_FOLDER="$XDG_CACHE_HOME/yarn"

# bat, wakatime, nnn
export BAT_CONFIG_PATH="$DOTFILES/config/bat/bat.conf"
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
# export NNN_FIFO="/tmp/nnn.fifo"
# export NNN_PLUG='f:finder;o:fzopen;p:mocplay;d:diffs;t:nmount;v:imgview'

# python, pyenv
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"

# 1password
export OP_BIOMETRIC_UNLOCK_ENABLED=true
export SSH_AUTH_SOCK="$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"

