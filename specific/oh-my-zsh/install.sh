#!/bin/bash

export ZSH=~/.config/ohmyzsh

if [ ! -d $ZSH ]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git $ZSH
fi

ZSH_THEME_DIR=${ZSH_CUSTOM:-~/.config/ohmyzsh/custom}/themes/powerlevel10k
if [ ! -d "$ZSH_THEME_DIR" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_THEME_DIR"
fi
