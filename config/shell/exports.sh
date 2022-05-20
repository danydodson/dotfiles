#!/bin/bash

#######################################################################
# language                                                            #
#######################################################################

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

#######################################################################
# editor                                                              #
#######################################################################

export EDITOR="vim"
export VISUAL="$EDITOR"
export SYSTEMD_EDITOR="$EDITOR"

#######################################################################
# dotfiles                                                            #
#######################################################################

export DOTFILES="$HOME"/Developer/Dotfiles

#######################################################################
# xdg                                                                 #
#######################################################################

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$XDG_CONFIG_HOME"/cache
export XDG_DATA_HOME="$XDG_CONFIG_HOME"/local/share
export XDG_STATE_HOME="$XDG_CONFIG_HOME"/local/state
export XDG_DESKTOP_DIR="$HOME"/Desktop
export XDG_DOWNLOAD_DIR="$HOME"/Downloads
export XDG_PUBLICSHARE_DIR="$HOME"/Public
export XDG_DOCUMENTS_DIR="$HOME"/Documents
export XDG_MUSIC_DIR="$HOME"/Music
export XDG_PICTURES_DIR="$HOME"/Pictures
export XDG_VIDEOS_DIR="$HOME"/Movies

#######################################################################
# Links                                                               #
#######################################################################

export DEVELOPER=~/Developer

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
_token=$(cat "$DOTFILES"/config/git/token)
export HOMEBREW_GITHUB_API_TOKEN=$_token

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
# babel                                                              #
#######################################################################

export BABEL_CACHE_PATH="$XDG_CACHE_HOME/babel/babel.json"

#######################################################################
# docker                                                              #
#######################################################################

export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

#######################################################################
# npm                                                                 #
#######################################################################

export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
export COREPACK_HOME="$XDG_CONFIG_HOME"/node/corepack

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
# autoenv                                                             #
#######################################################################

export AUTOENV_AUTH_FILE="$XDG_STATE_HOME"/autoenv/.autoenv_authorized
export AUTOENV_ENV_FILENAME=.a.env
export AUTOENV_ENABLE_LEAVE="true"
export AUTOENV_ENV_LEAVE_FILENAME=.b.env

#######################################################################
# less                                                                #
#######################################################################

export LESSHISTFILE=-
