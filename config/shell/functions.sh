#!/bin/bash

#######################################################################
# log helpers                                                         #
#######################################################################

_info() {
  echo -e "\033[36m[INFO]\033[0m $1"
}

_ok() {
  echo -e "\033[32m[OK]\033[0m $1"
}

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
# open dotfiles in fzf                                                #
#######################################################################

function fzf-sl() {
  _SCRIPTS_PATH="$HOME/Developer/Dotfiles/"

  _allfiles=$(rg -t sh --files "$_SCRIPTS_PATH")
  # _filteredfiles=$(echo "$_allfiles" | grep -v "_templates/\|setup/")
  # _cutpaths=$(echo "$_filteredfiles" | cut -c 30-)
  _cutpaths=$(echo "$_allfiles" | cut -c 30-)

  local selected
  if selected=$(echo "$_cutpaths" | fzf --height 40% --preview "bat --style=grid --color=always '$_SCRIPTS_PATH{}'" -q "$LBUFFER"); then
    LBUFFER="$_SCRIPTS_PATH$selected"
  fi
  zle redisplay
}

zle -N fzf-sl
bindkey '^X' fzf-sl

#######################################################################
# other                                                               #
#######################################################################

function wttr() {
  curl http://wttr.in/"$1"
}

function ipinf0() {
  curl http://ipinfo.io/"$1"
}
