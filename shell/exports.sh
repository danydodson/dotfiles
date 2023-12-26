#!/bin/bash

#######################################################################
# local: language
#######################################################################

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

#######################################################################
# local: editor
#######################################################################

export EDITOR="vim"
export KEYTIMEOUT=1
export VISUAL="$EDITOR"
export SYSTEMD_EDITOR="$EDITOR"
export TERM=xterm-256color

#######################################################################
# xdg
#######################################################################

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$XDG_CONFIG_HOME"/cache
export XDG_DATA_HOME="$XDG_CONFIG_HOME"/local/share
export XDG_STATE_HOME="$XDG_CONFIG_HOME"/local/state
export XDG_DESKTOP_DIR="$HOME"/Desktop
export XDG_DOCUMENTS_DIR="$HOME"/Documents
export XDG_DOWNLOAD_DIR="$HOME"/Downloads
export XDG_MUSIC_DIR="$HOME"/Documents/Music
export XDG_VIDEOS_DIR="$HOME"/Movies
export XDG_PICTURES_DIR="$HOME"/Pictures

#######################################################################
# local environment
#######################################################################

export DEVELOPER="$HOME/Developer"
export DOTFILES="$HOME/.dotfiles"

#######################################################################
# ack
#######################################################################

export ACKRC="${DOTFILES}/config/ack/ackrc"

#######################################################################
# bat
#######################################################################

export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/conf"

#######################################################################
# cargo
#######################################################################

export CARGO_HOME="${XDG_CONFIG_HOME}/cargo"
export RUSTUP_HOME="${XDG_CONFIG_HOME}/rust"

#######################################################################
# dfx
#######################################################################

export DFX_CONFIG_ROOT="${XDG_CONFIG_HOME}/dfx"

#######################################################################
# go
#######################################################################

export GOPATH="${XDG_DATA_HOME}/go"

#######################################################################
# homebrew
#######################################################################

export HOMEBREW_ROOT="/opt/homebrew"
export HOMEBREW_NO_ANALYTICS=true
export HOMEBREW_NO_INSTALL_CLEANUP=true

#######################################################################
# ls
#######################################################################

export LS_OPTS='--color=auto'

#######################################################################
# npm
#######################################################################

export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"

#######################################################################
# nvm
#######################################################################

export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export NVM_NODEJS_ORG_MIRROR=http://nodejs.org/dist
export NVM_HOMEBREW="/opt/homebrew/opt/nvm"

#######################################################################
# onepassword
#######################################################################

export OP_BIOMETRIC_UNLOCK_ENABLED=true
export OP_CACHE="${XDG_CACHE_HOME}/op"

#######################################################################
# python
#######################################################################

export PYENV_ROOT="${HOME}/.config/pyenv"
export PYTHONSTARTUP="${DOTFILES}/.config/python/pythonstartup.py"

#######################################################################
# ssh
#######################################################################

export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

#######################################################################
# vim
#######################################################################

export VIMCONFIG="${XDG_CONFIG_HOME}"/vim
export MYVIMRC="${XDG_CONFIG_HOME}"/vim/vimrc
export VIMINIT="source ${XDG_CONFIG_HOME}/vim/vimrc"

#######################################################################
# wakatime
#######################################################################

export WAKATIME_HOME="${XDG_CONFIG_HOME}/wakatime"

#######################################################################
# wgwet
#######################################################################

export WGETRC="$DOTFILES/config/wget/wgetrc"

#######################################################################
# yarn cache
#######################################################################

export YARN_CACHE_FOLDER="${XDG_CACHE_HOME}/yarn"

#######################################################################
# zsh
#######################################################################

export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export ZSH_CACHE_DIR="$ZDOTDIR"
export ZSH="$XDG_DATA_HOME"/oh-my-zsh
