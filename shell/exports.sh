#!/bin/bash

# editor
export EDITOR="vim"
export GIT_EDITOR="vim"
export BUNDLER_EDITOR=$EDITOR

# dirs
export DOTFILES="$HOME/.dotfiles"

# xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# zsh
export ZSH="$DOTFILES/config/omz"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_CUSTOM="$DOTFILES/config/zsh/custom"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"

# homebrew
export HOMEBREW_ROOT="/opt/homebrew"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export HOMEBREW_NO_ANALYTICS=true
export HOMEBREW_NO_INSTALL_CLEANUP=false
export HOMEBREW_NO_ENV_HINTS=true
export HOMEBREW_NO_AUTO_UPDATE=true

# pkg managers
export GOPATH="$XDG_CONFIG_HOME/go"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export BUN_INSTALL="$XDG_CONFIG_HOME/bun"
export DENO_INSTALL="$XDG_CONFIG_HOME/deno"
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export RUSTUP_HOME="$XDG_CONFIG_HOME/rust"
export CONDA_ROOT="$XDG_CONFIG_HOME/conda"
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME/yarn"

# tools
export OP_BIOMETRIC_UNLOCK_ENABLED=true
export OP_CACHE="$XDG_CACHE_HOME/op"
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/conf"
export LS_COLORS='*.*=0;31:di=01;34:ln=01;36:ex=0;32:*.mp4=01;93:*.mov=01;93:*.mp3=01;93:*.dmg=0;35:*.zip=0;35:'
export SSH_AUTH_SOCK="$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
