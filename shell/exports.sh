#!/bin/bash

#######################################################################
# language                                                            #
#######################################################################

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LS_OPTS='--color=auto'

#######################################################################
# editor                                                              #
#######################################################################

export EDITOR="vim"
export VISUAL="$EDITOR"
export SYSTEMD_EDITOR="$EDITOR"

#######################################################################
# xdg                                                                 #
#######################################################################

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$XDG_CONFIG_HOME"/cache
export XDG_DATA_HOME="$XDG_CONFIG_HOME"/local/share
export XDG_STATE_HOME="$XDG_CONFIG_HOME"/local/state
export XDG_DESKTOP_DIR="$HOME"/Desktop
export XDG_DOCUMENTS_DIR="$HOME"/Documents
export XDG_DOWNLOAD_DIR="$XDG_DOCUMENTS_DIR"/Downloads
export XDG_MUSIC_DIR="$XDG_DOCUMENTS_DIR"/Music
export XDG_VIDEOS_DIR="$XDG_DOCUMENTS_DIR"/Movies
export XDG_PICTURES_DIR="$XDG_DOCUMENTS_DIR"/Pictures

#######################################################################
# local                                                               #
#######################################################################

export DEVELOPER="$XDG_DOCUMENTS_DIR/Developer"

#######################################################################
# zsh                                                                 #
#######################################################################

export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export ZSH_CACHE_DIR="$ZDOTDIR"
export ZSH="$XDG_DATA_HOME"/oh-my-zsh

#######################################################################
# homebrew                                                            #
#######################################################################

export HOMEBREW_ROOT=/opt/homebrew
export HOMEBREW_NO_ANALYTICS=true
export HOMEBREW_NO_INSTALL_CLEANUP=true
export "$(grep -E -v '^#' "$DOTFILES/.env" | xargs)"
export HOMEBREW_GITHUB_API_TOKEN=$HOMEBREW_TOKEN

#######################################################################
# vim                                                                 #
#######################################################################

export MYVIMRC="$XDG_CONFIG_HOME"/vim/vimrc
export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"

#######################################################################
# python                                                              #
#######################################################################

export PYENV_ROOT="$HOME/.config/pyenv"

#######################################################################
# npm                                                                 #
#######################################################################

export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm

#######################################################################
# yarn                                                                #
#######################################################################

export YARN_CACHE_FOLDER="$XDG_CACHE_HOME"/yarn

#######################################################################
# z                                                                   #
#######################################################################

export _Z_DATA="$ZDOTDIR"/.z

#######################################################################
# wakatime                                                            #
#######################################################################

export WAKATIME_HOME="$XDG_CONFIG_HOME"/wakatime

#######################################################################
# aws                                                                 #
#######################################################################

export AWS_PROFILE="default"

#######################################################################
# less                                                                #
#######################################################################

export LESSHISTFILE=-
