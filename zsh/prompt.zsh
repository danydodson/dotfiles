#!/usr/bin/env zsh

# enable colors
export CLICOLOR=1

# pure prompt
fpath+=("$HOME/.dotfiles/plugins/pure")

autoload -U promptinit; promptinit


prompt pure
