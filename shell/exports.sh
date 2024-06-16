#!/bin/bash

# editor
export EDITOR="nvim"
export VISUAL="nvim"
export GIT_EDITOR="nvim"
# export MANPAGER="nvim"

# dotfiles
export DOTFILES="$HOME/.dotfiles"

# xdg XDG_DATA_DIRS
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# zsh, omz
export ZSH="${HOME}/.config/omz"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"
export ZSH_CUSTOM="${XDG_CONFIG_HOME}/omz/custom"

# brew
export HOMEBREW_BREWFILE="${XDG_CONFIG_HOME}/brewfile"
export HOMEBREW_NO_ANALYTICS=true
export HOMEBREW_NO_INSTALL_CLEANUP=true
export HOMEBREW_NO_ENV_HINTS=true

# go, rust, java
export GOPATH="$XDG_CONFIG_HOME/go"
export GOROOT="/opt/homebrew/opt/go/libexec"
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export RUSTUP_HOME="$XDG_CONFIG_HOME/rust"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@11/include"

# npm, deno, yarn, pnpm, bun, gem, less
export BUN_INSTALL="$XDG_CONFIG_HOME/bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export KITTY_CACHE_DIRECTORY="${XDG_CACHE_HOME}/kitty"
export DENO_INSTALL="$XDG_CONFIG_HOME/deno"
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME/yarn"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export GEM_HOME="$XDG_CONFIG_HOME/gem"
export GEM_PATH="$XDG_CONFIG_HOME/gem"

# wakatime, bat, vimrc
export WAKATIME_HOME=$XDG_CONFIG_HOME/wakatime
export BAT_CONFIG_PATH="$DOTFILES/config/bat/bat.conf"
# export MYVIMRC="$HOME/.config/vim/vimrc"

# python, conda
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
export CONDA_ROOT="$XDG_CONFIG_HOME/conda"

# 1password
export OP_CACHE=$XDG_CACHE_HOME/op
export OP_BIOMETRIC_UNLOCK_ENABLED=true
export SSH_AUTH_SOCK="$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"

