#!/usr/bin/env zsh

# enable colors
export CLICOLOR=1

# pure prompt
fpath+=("$HOME/.config/ohmyzsh/custom/themes/pure")

autoload -U promptinit; promptinit


prompt pure
