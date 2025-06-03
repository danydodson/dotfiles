#!/usr/bin/env zsh

# if using pure prompt
fpath+=("$HOME/.config/ohmyzsh/custom/themes/pure")

# set to empty
ZSH_THEME=""

autoload -U promptinit; promptinit
prompt pure