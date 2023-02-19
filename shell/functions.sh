#!/usr/bin/env bash

#######################################################################
# modify path                                                         #
#######################################################################

function path-remove() {
  PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

function path-append() {
  path-remove "$1"
  PATH="${PATH:+"$PATH:"}$1"
}

function path-prepend() {
  path-remove "$1"
  PATH="$1${PATH:+":$PATH"}"
}

#######################################################################
# modify fpath                                                        #
#######################################################################

function fpath-remove() {
  FPATH=$(echo -n "$FPATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

function fpath-append() {
  fpath-remove "$1"
  FPATH="${FPATH:+"$FPATH:"}$1"
}

function fpath-prepend() {
  path-remove "$1"
  FPATH="$1${FPATH:+":$FPATH"}"
}

#######################################################################
# Variables                                                           #
#######################################################################

function developer() {
  cd "$HOME/Developer" || exit
}

function served() {
  cd "$HOME/Developer/Served" || exit
}

function comic-shop() {
  cd "$HOME/Developer/Served/comic-shop" || exit
}

function connected() {
  cd "$HOME/Developer/Served/connected" || exit
}

function danydodson-dev() {
  cd "$HOME/Developer/Served/danydodson-dev" || exit
}

function fatcats() {
  cd "$HOME/Developer/Served/fatcats" || exit
}

function my-links() {
  cd "$HOME/Developer/Served/my-links" || exit
}

function spotify-tracks() {
  cd "$HOME/Developer/Served/spotify-tracks" || exit
}

#######################################################################
# open .dotfiles in fzf                                                #
#######################################################################

__fzf_scripts() {
  _scripts_path="$DOTFILES/"
  _allfiles=$(rg -t sh --files "$_scripts_path")
  _cutpaths=$(echo "$_allfiles" | cut -c 22-)
  local selected
  if selected=$(echo "$_cutpaths" | fzf --height 100% --preview "bat --style=grid --color=always '$_scripts_path{}'" -q "$LBUFFER"); then
    LBUFFER="$_scripts_path$selected"
  fi
  zle redisplay
}

zle -N __fzf_scripts
bindkey '^X' __fzf_scripts

#######################################################################
# alt+left to previous dir
#######################################################################

__prev_dir() {
  popd 2>/dev/null || exit
  zle accept-line
}
zle -N __prev_dir
bindkey '^[^[[D' __prev_dir

#######################################################################
# other                                                               #
#######################################################################

function wttr() {
  curl http://wttr.in/"$1"
}

function ipinf0() {
  curl http://ipinfo.io/"$1"
}


