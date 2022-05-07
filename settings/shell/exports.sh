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
# dotfiles                                                           #
#######################################################################

export DOTFILES="$HOME"/Dotfiles
export LDOTDIR="$DOTFILES"/local
export VDOTDIR="$DOTFILES"/vim

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
export HOMEBREW_GITHUB_API_TOKEN=$(cat "$DOTFILES"/settings/local/github-api-token)

#######################################################################
# z                                                                   #
#######################################################################

export _Z_DATA="$ZDOTDIR"/.z

#######################################################################
# python                                                              #
#######################################################################

# export PYTHONPATH=/usr/local/lib/python2.6/site-packages

#######################################################################
# vim                                                                 #
#######################################################################

export MYVIMRC="$XDG_CONFIG_HOME"/vim/vimrc
export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"

#######################################################################
# npm                                                                 #
#######################################################################

export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm

#######################################################################
# yarn                                                                #
#######################################################################
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME"/yarn

#######################################################################
# wakatime                                                            #
#######################################################################

export WAKATIME_HOME="$XDG_CONFIG_HOME"/wakatime

#######################################################################
# terminfo                                                            #
#######################################################################

# export TERMINFO="$DOTFILES"/settings/terminfo

#######################################################################
# less                                                                #
#######################################################################

export LESSHISTFILE=-
