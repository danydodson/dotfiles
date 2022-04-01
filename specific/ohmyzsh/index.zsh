#!/bin/bash

export ZSH_THEME=""
export DEFAULT_USER=$(whoami)

plugins+=(gh node npm brew docker docker-compose git)

source $ZSH/oh-my-zsh.sh

source $HOME/.config/iterm2/iterm2_shell_integration.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
