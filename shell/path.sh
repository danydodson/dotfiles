#!/usr/bin/env bash

#######################################################################
# path                                                                #
#######################################################################

path-prepend "/opt/homebrew/bin"
path-prepend "/opt/homebrew/sbin"
path-prepend "/opt/homebrew/opt/coreutils/libexec/gnubin"
path-prepend "/opt/homebrew/opt/findutils/libexec/gnubin"
path-prepend "/opt/homebrew/opt/grep/libexec/gnubin"
path-prepend "/opt/homebrew/opt/openssl@3/bin"
path-prepend "/opt/homebrew/opt/bc/bin"
path-prepend "/opt/homebrew/opt/fzf/bin"
path-prepend "$HOME/.config/iterm2/utils"
path-prepend "$DOTFILES/bin"

#######################################################################
# fpath                                                               #
#######################################################################

fpath-prepend "/opt/homebrew/share/zsh/site-functions"
fpath-prepend "/opt/homebrew/share/zsh/zsh-completions"
