#!/bin/bash

# editor
export EDITOR="vim"
export GIT_EDITOR="vim"
export BUNDLER_EDITOR=$EDITOR

# misc
export DOTFILES="$HOME/.dotfiles"

# xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# zsh
export ZSH="$DOTFILES/config/omz"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_CUSTOM="$DOTFILES/custom"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
# export GENCOMPL_FPATH="$ZSH_CUSTOM/plugins/my-zsh-completions/src/custom"

# brew
export HOMEBREW_NO_ANALYTICS=true
export HOMEBREW_NO_ENV_HINTS=true
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_NO_INSTALL_CLEANUP=false

# bat
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/conf"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# go
export GOPATH="$XDG_CONFIG_HOME/go"
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export RUSTUP_HOME="$XDG_CONFIG_HOME/rust"

# node
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export BUN_INSTALL="$XDG_CONFIG_HOME/bun"
export DENO_INSTALL="$XDG_CONFIG_HOME/deno"
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME/yarn"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

# python
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
export CONDA_ROOT="$XDG_CONFIG_HOME/conda"

# 1password
export OP_CACHE=$XDG_CACHE_HOME/op
export OP_BIOMETRIC_UNLOCK_ENABLED=true
export SSH_AUTH_SOCK="$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# wakatime
export WAKATIME_HOME=$XDG_CONFIG_HOME/wakatime

# path
path-prepend "$HOME"/.dotfiles/bin
path-append "$HOME"/.config/pyenv/shims
path-append /opt/homebrew/opt/fzf/bin

# fpath
fpath-prepend /opt/homebrew/share/zsh/site-functions
fpath-prepend /opt/homebrew/share/zsh/zsh-completions