#!/bin/bash

# locale language
export LANG="en_US.UTF-8"

# local editor
export EDITOR="nvim-config"
export KEYTIMEOUT=1
export VISUAL="$EDITOR"
export SYSTEMD_EDITOR="$EDITOR"
export TERM=xterm-256color

# local env variables
export DEVELOPER="$HOME/Developer"
export DOTFILES="$HOME/.dotfiles"

# xdg config
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_STATE_HOME="$XDG_CONFIG_HOME/local/state"

# ack
export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"

# bat
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/conf"

# bun
export BUN_INSTALL="$XDG_CONFIG_HOME/bun"

# conda
export CONDA_ROOT="$XDG_CONFIG_HOME/conda"

# cargo
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export RUSTUP_HOME="$XDG_CONFIG_HOME/rust"

# dfx
export DFX_CONFIG_ROOT="$XDG_CONFIG_HOME/dfx"

# go
export GOPATH="$XDG_CONFIG_HOME/go"

# git
export GIT_EDITOR="nvim-config"

# homebrew
export HOMEBREW_ROOT="/opt/homebrew"
export HOMEBREW_REPOSITORY=/opt/homebrew
export HOMEBREW_NO_ANALYTICS=true

# gls colors
export LS_COLORS="$LS_COLORS:*.*=0;31:di=01;34:ln=01;36:ex=0;32:*.mp4=01;93:*.mov=01;93:*.mp3=01;93:*.dmg=0;35:*.zip=0;35:"

# npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_PYTHON="$XDG_CONFIG_HOME/pyenv/shims/python"

# nvm
export NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist
export NVM_NODEJS_ORG_MIRROR=$XDG_CONFIG_HOME/nvim

# 1password
export OP_BIOMETRIC_UNLOCK_ENABLED=true
export OP_CACHE="$XDG_CACHE_HOME/op"

# For compilers to find zlib
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"

# For pkg-config to find zlib
export PKG_CONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"

# python
export PYENV_ROOT="$HOME/.config/pyenv"
export PYTHONSTARTUP="$XDG_CONFIG_HOME:-$HOME/.config/python/pythonstartup.py"

# ssh
export SSH_AUTH_SOCK="$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# starship.rs
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/config.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"

# vim
export VIMCONFIG="$XDG_CONFIG_HOME"/vim
export MYVIMRC="$XDG_CONFIG_HOME"/vim/vimrc
# export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"

# wakatime
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"

# wgwet
export WGETRC="$XDG_CONFIG_HOME/config/wget/wgetrc"

# yarn cache
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME/yarn"

# oh-my-zsh
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
export ZSH="$XDG_CONFIG_HOME"/oh-my-zsh
