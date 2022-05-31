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
# open .dotfiles in fzf                                                #
#######################################################################

__fzf_scripts() {
  _scripts_path="$DOTFILES/"
  _allfiles=$(rg -t sh --files "$_scripts_path")
  _cutpaths=$(echo "$_allfiles" | cut -c 32-)
  local selected
  if selected=$(echo "$_cutpaths" | fzf --height 60% --preview "bat --style=grid --color=always '$_scripts_path{}'" -q "$LBUFFER"); then
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
bindkey '^[[1;3D' __prev_dir

#######################################################################
# other                                                               #
#######################################################################

function wttr() {
  curl http://wttr.in/"$1"
}

function ipinf0() {
  curl http://ipinfo.io/"$1"
}
