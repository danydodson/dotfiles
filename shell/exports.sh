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
# cargo
#######################################################################

export CARGO_HOME="${XDG_CONFIG_HOME}/cargo"

#######################################################################
# composer
#######################################################################

export COMPOSER_HOME="${XDG_CONFIG_HOME}/composer"
export COMPOSER_CACHE_DIR="${XDG_CACHE_HOME}/composer"

#######################################################################
# docker
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
# OPENSSL1_LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib:"
# OPENSSL1_CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include:"
# OPENSSL1_PKG_CONFIG_PATH="/opt/homebrew/Cellar/openssl@1.1/lib/pkgconfig:"

# [openssl@3]
# OPENSSL3_LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib:"
# OPENSSL3_CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include:"
# OPENSSL3_PKG_CONFIG_PATH="/opt/homebrew/Cellar/openssl@3/lib/pkgconfig:"

# [openjdk@3]
# OPENJDK_LDFLAGS="-L/opt/homebrew/opt/openjdk/lib:"
# OPENJDK_CPPFLAGS="-I/opt/homebrew/opt/openjdk/include:"

# [php@8.1]
# PHP8_LDFLAGS="-L/opt/homebrew/opt/php@8.1/lib:"
# PHP8_CPPFLAGS="-I/opt/homebrew/opt/php@8.1/include:"

# HOMEBREW_PKG_CONFIG_PATH="/opt/homebrew/opt/pkgconfig"

# [pkg-config]
# export LDFLAGS="$OPENSSL1_LDFLAGS:$OPENSSL3_LDFLAGS:$OPENJDK_LDFLAGS:$PHP8_LDFLAGS:$LDFLAGS"
# export CPPFLAGS=":$OPENSSL1_CPPFLAGS:$OPENSSL3_CPPFLAGS:$OPENJDK_CPPFLAGS:$PHP8_CPPFLAGS:$CPPFLAGS"
# export PKG_CONFIG_PATH="$HOMEBREW_PKG_CONFIG_PATH:$OPENSSL1_PKG_CONFIG_PATH:$OPENSSL3_PKG_CONFIG_PATH:$PKG_CONFIG_PATH"

#######################################################################
# java
#######################################################################

export JAVA_HOME="/opt/homebrew/opt/openjdk/libexec/openjdk.jdk"

#######################################################################
# less
#######################################################################

export LESSHISTFILE=- # don't write history
# export LESSHISTFILE="$XDG_STATE_HOME/lesshst"

#######################################################################
# ls
#######################################################################

export LS_OPTS='--color=auto'
export LS_COLORS="$LS_COLORS:di=0;36:ln=0;93:ex=0;35:"
# export LSCOLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=01;34:ow=01;34:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

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
# onepassword
#######################################################################
   
export OP_BIOMETRIC_UNLOCK_ENABLED=true
# export OP_CONFIG_DIR="${XDG_CONFIG_HOME}/op"

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


