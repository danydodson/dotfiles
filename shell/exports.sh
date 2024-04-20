#!/bin/bash

# lang
export LANG="en_US.UTF-8"

# editor
export EDITOR='nvim'

# local env
export DOTFILES="$HOME/.dotfiles"

# xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_STATE_HOME="$XDG_CONFIG_HOME/local/state"

# bat
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/conf"

# bun
export BUN_INSTALL="$XDG_CONFIG_HOME/bun"

# conda
export CONDA_ROOT="$XDG_CONFIG_HOME/conda"

# cargo
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export RUSTUP_HOME="$XDG_CONFIG_HOME/rust"

# go
export GOPATH="$XDG_CONFIG_HOME/go"

# brew
export HOMEBREW_ROOT="/opt/homebrew"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export HOMEBREW_NO_ANALYTICS=true

# gls colors
export LS_COLORS="$LS_COLORS:*.*=0;31:di=01;34:ln=01;36:ex=0;32:*.mp4=01;93:*.mov=01;93:*.mp3=01;93:*.dmg=0;35:*.zip=0;35:"

# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"

# 1password
export OP_BIOMETRIC_UNLOCK_ENABLED=true
export OP_CACHE="$XDG_CACHE_HOME/op"

# pnpm
export PNPM_HOME="$XDG_DATA_HOME/pnpm"

# pyenv
export PYENV_ROOT="$HOME/.config/pyenv"

# ssh
export SSH_AUTH_SOCK="$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# vim
export VIMCONFIG="$XDG_CONFIG_HOME/vim"
export MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"

# wakatime
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"

# yarn cache
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME/yarn"

# zsh
export ZSH="$DOTFILES/config/omz"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_CUSTOM="$DOTFILES/config/zsh/custom"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"