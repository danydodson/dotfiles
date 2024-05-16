#!/bin/bash

# editor
export EDITOR="nvim"
export GIT_EDITOR="nvim"
export BUNDLER_EDITOR=$EDITOR

# xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# misc
export DOTFILES="$HOME/.dotfiles"

# zsh, omz
export ZSH="${HOME}/.config/omz"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME}/zsh"
export ZSH_CUSTOM="${XDG_CONFIG_HOME}/omz/custom"

# brew
export HOMEBREW_NO_ANALYTICS=true
export HOMEBREW_NO_ENV_HINTS=true
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_NO_INSTALL_CLEANUP=false
export HOMEBREW_BUNDLE_INSTALL_CLEANUP=true

# go, rust
export GOPATH="$XDG_CONFIG_HOME/go"
export CARGO_HOME="$XDG_CONFIG_HOME/cargo"
export RUSTUP_HOME="$XDG_CONFIG_HOME/rust"

# npm, deno, yarn, pnpm, bun, gem
export BUN_INSTALL="$XDG_CONFIG_HOME/bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export DENO_INSTALL="$XDG_CONFIG_HOME/deno"
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME/yarn"
export GEM_HOME="$XDG_CONFIG_HOME/gem"
export GEM_PATH="$XDG_CONFIG_HOME/gem"

# vim
# export MYVIMRC="$HOME/.config/vim/vimrc"
# export VIMINIT="source $MYVIMRC"

# python, conda
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
export CONDA_ROOT="$XDG_CONFIG_HOME/conda"

# 1password
export OP_CACHE=$XDG_CACHE_HOME/op
export OP_BIOMETRIC_UNLOCK_ENABLED=true
export SSH_AUTH_SOCK="$HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# wakatime, bat
export WAKATIME_HOME=$XDG_CONFIG_HOME/wakatime
export BAT_CONFIG_PATH="$DOTFILES/config/bat/bat.conf"

# path
path-append "$HOME"/.local/bin
path-append "$HOME"/.config/iterm2
path-append "$HOME"/.config/pyenv/shims
path-append /opt/homebrew/opt/fzf/bin
path-prepend "$HOME"/.dotfiles/bin

# fpath
fpath-prepend /opt/homebrew/share/zsh/site-functions
fpath-prepend /opt/homebrew/share/zsh/zsh-completions
