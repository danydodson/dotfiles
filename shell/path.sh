#!/usr/bin/env bash

#######################################################################
# path
#######################################################################

path-prepend "$DOTFILES/bin"
path-prepend "$HOME/.config/iterm2"
path-prepend "$HOME/.config/local/bin"
path-prepend "$HOME/.config/pyenv/shims"
path-prepend "$HOME/.config/local/share/go/bin"
path-prepend "/opt/homebrew/opt/go/libexec/bin"
path-prepend "/opt/homebrew/opt/coreutils/libexec/gnubin"
path-prepend "/opt/homebrew/opt/findutils/libexec/gnubin"
path-prepend "/opt/homebrew/opt/brew/libexec/gnubin"
path-prepend "/opt/homebrew/opt/curl/bin"
path-prepend "/opt/homebrew/opt/bc/bin"
path-prepend "/opt/homebrew/opt/fzf/bin"
path-prepend "/opt/homebrew/sbin"
path-prepend "/opt/homebrew/bin"

#######################################################################
# fpath
#######################################################################

fpath-prepend "/opt/homebrew/share/zsh/site-functions"
fpath-prepend "/opt/homebrew/share/zsh/zsh-completions"

