#!/usr/bin/env bash

export ZSH=~/.config/ohmyzsh

if [ ! -d $ZSH ]; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git $ZSH
fi

