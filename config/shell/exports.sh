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
# xdg                                                                 #
#######################################################################

export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$XDG_CONFIG_HOME"/cache
export XDG_DATA_HOME="$XDG_CONFIG_HOME"/local/share
export XDG_STATE_HOME="$XDG_CONFIG_HOME"/local/state
export XDG_DESKTOP_DIR="$HOME"/Desktop
export XDG_DOCUMENTS_DIR="$HOME"/Documents
export XDG_MUSIC_DIR="$XDG_DOCUMENTS_DIR"/Music
export XDG_PICTURES_DIR="$XDG_DOCUMENTS_DIR"/Media
export XDG_DOWNLOAD_DIR="$HOME"/Downloads
export XDG_PUBLICSHARE_DIR="$HOME"/Public
export XDG_VIDEOS_DIR="$HOME"/Movies

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
git_token=$(cat "$DOTFILES"/scripts/brew/git-token)
export HOMEBREW_GITHUB_API_TOKEN=$git_token

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
# export COREPACK_HOME="$XDG_DATA_HOME"/node/corepack

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
