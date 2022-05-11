#!/bin/bash

#######################################################################
# Path                                                                #
#######################################################################

path-prepend "$HOME/Dotfiles/bin"
path-prepend "/opt/homebrew/bin"
path-prepend "/opt/homebrew/sbin"
path-prepend "/opt/homebrew/bin/coreutils/libexec/gnubin"
path-prepend "/opt/homebrew/bin/findutils/libexec/gnubin"
path-prepend "/opt/homebrew/bin/grep/libexec/gnubin"
path-prepend "/opt/homebrew/bin/bc/bin"
path-prepend "/opt/homebrew/bin/fzf/bin"
path-prepend "$HOME/.config/iterm2/utilities"

fpath-prepend "/opt/homebrew/share/zsh/site-functions"

# typeset -gU cdpath PATH path FPATH fpath MANPATH manpath
