#!/bin/bash

#######################################################################
# language                                                            #
#######################################################################

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

#######################################################################
# ls                                                                  #
#######################################################################

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
# Others
#######################################################################

# For compilers to find openssl@3 you may need to set:
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"

# For pkg-config to find openssl@3 you may need to set:
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

# homebrew
export HOMEBREW_ROOT="/opt/homebrew"
export HOMEBREW_NO_ANALYTICS=true
export HOMEBREW_NO_INSTALL_CLEANUP=true
# export "$(grep -E -v '^#' "$DOTFILES/.env" | xargs)"
# export HOMEBREW_GITHUB_API_TOKEN=$HOMEBREW_TOKEN

# android sdk
# export ANDROID_HOME="/Users/Dany/Library/Android/sdk"

# android ndk
# export ANDROID_NDK_HOME="/opt/homebrew/share/android-ndk"

# vim
export VIMCONFIG="${XDG_CONFIG_HOME}"/vim
export MYVIMRC="$XDG_CONFIG_HOME"/vim/vimrc
export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"

# bat
export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/bat.conf"

# python
export PYENV_ROOT="$HOME/.config/pyenv"
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonstartup.py"

# ipython
export IPYTHONDIR="$HOME/.config/ipython"

# ack
export ACKRC="${DOTFILES}/config/ack/dot.ackrc"

# z
export _Z_DATA="${ZDOTDIR}/.z"

# go
export GOPATH="${XDG_CONFIG_HOME}/go"
export GOMODCACHE="${XDG_CONFIG_HOME}/go/pkg/mod"

# wakatime
export WAKATIME_HOME="${XDG_CONFIG_HOME}/wakatime"

# aws
export AWS_CONFIG_FILE="${DOTFILES}/config/aws"
export AWS_PROFILE="default"

# less
export LESSHISTFILE=-

# babel
export BABEL_CACHE_PATH="${HOME}/.local/babel.json"

# bazaar
export BZRPATH="${XDG_CONFIG_HOME}/bazaar"
export BZR_PLUGIN_PATH="${XDG_DATA_HOME}/bazaar"
export BZR_HOME="${XDG_CACHE_HOME}/bazaar"

# composer
export COMPOSER_HOME="${XDG_CONFIG_HOME}/composer"
export COMPOSER_CACHE_DIR="${XDG_CACHE_HOME}/composer"

# docker
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

# gpg | on mac this should already
# set by dotfiles.plist using launchd
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"

# mysql
export MYSQL_HISTFILE="${XDG_CACHE_HOME}/mysql_histfile"

# readline
export INPUTRC="${DOTFILES}/shell/dot.inputrc"

# -shellcheck
export SHELLCHECK_OPTS="--exclude=SC1090,SC2148"

# terminfo
export TERMINFO="${XDG_DATA_HOME}/terminfo"

# vagrant
export VAGRANT_HOME="${XDG_DATA_HOME}/vagrant"
export VAGRANT_ALIAS_FILE="${XDG_DATA_HOME}/vagrant/aliases"

# npm
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"
export NPMRC_STORE="${HOME}/.local/npmrcs"

# yarn cache
export YARN_CACHE_FOLDER="${XDG_CACHE_HOME}/yarn"
