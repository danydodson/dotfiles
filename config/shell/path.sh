#!/bin/bash

#######################################################################
# path                                                                #
#######################################################################

path-prepend "/opt/homebrew/bin"
path-prepend "/opt/homebrew/sbin"
path-prepend "/opt/homebrew/bin/coreutils/libexec/gnubin"
path-prepend "/opt/homebrew/bin/findutils/libexec/gnubin"
path-prepend "/opt/homebrew/bin/grep/libexec/gnubin"
path-prepend "/opt/homebrew/bin/bc/bin"
path-prepend "/opt/homebrew/bin/fzf/bin"
path-prepend "$HOME/Developer/Dotfiles/bin"
path-prepend "$HOME/.config/iterm2/utilities"

#######################################################################
# fpath                                                               #
#######################################################################

fpath-prepend "/opt/homebrew/share/zsh/site-functions"
fpath-prepend "/opt/homebrew/share/zsh/zsh-completions"

