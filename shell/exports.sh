#!/bin/bash

#######################################################################
# local: language
#######################################################################

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

#######################################################################
# local: editor
#######################################################################

export EDITOR="code"
export VISUAL="$EDITOR"
export SYSTEMD_EDITOR="$EDITOR"

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
export XDG_MUSIC_DIR="$HOME"/Music
export XDG_VIDEOS_DIR="$HOME"/Movies
export XDG_PICTURES_DIR="$HOME"/Pictures

#######################################################################
# local environment
#######################################################################

export DEVELOPER="$HOME/Developer"
export DOTFILES="$HOME/.dotfiles"

export "$(grep -E -v '^#' "$DOTFILES/.env" | xargs)"
export HOMEBREW_GITHUB_API_TOKEN=$HOMEBREW_TOKEN

#######################################################################
# ack
#######################################################################

export ACKRC="${DOTFILES}/config/ack/dot.ackrc"

#######################################################################
# bat
#######################################################################

export BAT_CONFIG_PATH="$XDG_CONFIG_HOME/bat/bat.conf"

#######################################################################
# aws
#######################################################################

export AWS_CONFIG_FILE="${DOTFILES}/config/aws"
export AWS_PROFILE="default"

#######################################################################
# composer
#######################################################################

export COMPOSER_HOME="${XDG_CONFIG_HOME}/composer"
export COMPOSER_CACHE_DIR="${XDG_CACHE_HOME}/composer"

#######################################################################
# composer
#######################################################################

# export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"

#######################################################################
# dfx
#######################################################################

export DFX_CONFIG_ROOT="${XDG_CONFIG_HOME}/dfinity"

#######################################################################
# go
#######################################################################

export GOPATH="${XDG_CONFIG_HOME}/go"
export GOMODCACHE="${XDG_CONFIG_HOME}/go/pkg/mod"

#######################################################################
# gpg
#######################################################################

export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"

#######################################################################
# homebrew
#######################################################################

export HOMEBREW_ROOT="/opt/homebrew"
export HOMEBREW_NO_ANALYTICS=true
export HOMEBREW_NO_INSTALL_CLEANUP=true

# [openssl@1]
OPENSSL1_LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib:"
OPENSSL1_CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include:"
OPENSSL1_PKG_CONFIG_PATH="/opt/homebrew/Cellar/openssl@1.1/lib/pkgconfig:"

# [openssl@3]
OPENSSL3_LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib:"
OPENSSL3_CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include:"
OPENSSL3_PKG_CONFIG_PATH="/opt/homebrew/Cellar/openssl@3/lib/pkgconfig:"

# [openjdk@3]
OPENJDK_LDFLAGS="-L/opt/homebrew/opt/openjdk/lib:"
OPENJDK_CPPFLAGS="-I/opt/homebrew/opt/openjdk/include:"

# [php@8.1]
PHP8_LDFLAGS="-L/opt/homebrew/opt/php@8.1/lib:"
PHP8_CPPFLAGS="-I/opt/homebrew/opt/php@8.1/include:"

HOMEBREW_PKG_CONFIG_PATH="/opt/homebrew/opt/pkgconfig"

# [pkg-config]
export LDFLAGS="$OPENSSL1_LDFLAGS:$OPENSSL3_LDFLAGS:$OPENJDK_LDFLAGS:$PHP8_LDFLAGS:$LDFLAGS"
export CPPFLAGS=":$OPENSSL1_CPPFLAGS:$OPENSSL3_CPPFLAGS:$OPENJDK_CPPFLAGS:$PHP8_CPPFLAGS:$CPPFLAGS"
export PKG_CONFIG_PATH="$HOMEBREW_PKG_CONFIG_PATH:$OPENSSL1_PKG_CONFIG_PATH:$OPENSSL3_PKG_CONFIG_PATH:$PKG_CONFIG_PATH"

#######################################################################
# java
#######################################################################

export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk"

#######################################################################
# less
#######################################################################

# export LESSHISTFILE=- # don't write history
export LESSHISTFILE="$XDG_STATE_HOME/lesshst"

#######################################################################
# ls
#######################################################################

export LS_OPTS='--color=auto'

#######################################################################
# mysql
#######################################################################

export MYSQL_HISTFILE="${XDG_CACHE_HOME}/mysql_histfile"

#######################################################################
# npm
#######################################################################

export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export NPM_CONFIG_CACHE="${XDG_CACHE_HOME}/npm"

#######################################################################
# nvm
#######################################################################

export NVM_DIR="$XDG_CONFIG_HOME/nvm"

#######################################################################
# python
#######################################################################

export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonstartup.py"

#######################################################################
# python pyenv
#######################################################################

export PYENV_ROOT="$HOME/.config/pyenv"

#######################################################################
# python jupyter
#######################################################################

export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter/config"

#######################################################################
# python ipython
#######################################################################

export IPYTHONDIR="$HOME/.config/ipython"

#######################################################################
# readline
#######################################################################

export INPUTRC="${DOTFILES}/config/readline/inputrc"

#######################################################################
# sc
#######################################################################

export SHELLCHECK_OPTS="--exclude=SC1090,SC2148,SC1071"

#######################################################################
# terminfo
#######################################################################

export TERMINFO="${XDG_DATA_HOME}/terminfo"

#######################################################################
# vim
#######################################################################

export VIMCONFIG="${XDG_CONFIG_HOME}"/vim
export MYVIMRC="$XDG_CONFIG_HOME"/vim/vimrc
export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"

#######################################################################
# wakatime
#######################################################################

export WAKATIME_HOME="${XDG_CONFIG_HOME}/wakatime"

#######################################################################
# wgwet
#######################################################################

export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

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

#######################################################################
# z
#######################################################################

export _Z_DATA="${ZDOTDIR}/.z"
