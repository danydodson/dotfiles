#!/usr/bin/env zsh

# pure
fpath+=("$HOME/.config/ohmyzsh/custom/themes/pure")

ZSH_THEME=""

autoload -U promptinit; promptinit

prompt pure

# p10k
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# [[ ! -f ${HOME}/.cache/p10k.zsh ]] || source ${HOME}/.cache/p10k.zsh

# ZSH_THEME="powerlevel10k/powerlevel10k"