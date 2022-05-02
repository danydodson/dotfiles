#!/bin/bash

export EDITOR='code'
export TMPDIR="$HOME/tmp"
export TERM="xterm-256color"
export LANG="en_US.UTF-8"

# xdg
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$XDG_CONFIG_HOME/local/share"
export XDG_CACHE_HOME="$XDG_CONFIG_HOME/cache"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"

# oh-my-zsh
export ZSH="$XDG_CONFIG_HOME/local/oh-my-zsh"

# z
export _Z_DATA="$ZDOTDIR/.z"

# asdf
export ASDF_DATA_DIR="$XDG_CONFIG_HOME/local/asdf"
export ASDF_CONFIG_FILE="$ASDF_DATA_DIR/asdfrc"

# ruby
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# npm cache
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"

# yarn cache
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME/yarn"

# wakatime
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"

# haxm
# export INTEL_HAXM_HOME="/opt/homebrew/opt/intel-haxm"