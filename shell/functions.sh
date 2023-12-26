#!/usr/bin/env bash

#######################################################################
# modify path
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
# modify fpath
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
# other functions
#######################################################################

# Generate passwords
randpass() {
  local len=${1:-32}
  openssl rand -base64 256 | tr -d '\n/+='| cut -c -$len
}

coloredEcho() {
  local exp="$1";
  local color="$2";
  local arrow="$3";
  if ! [[ $color =~ ^[0-9]$ ]] ; then
    case $(echo "$color" | tr '[:upper:]' '[:lower:]') in
      black) color=0 ;;
      red) color=1 ;;
      green) color=2 ;;
      yellow) color=3 ;;
      blue) color=4 ;;
      magenta) color=5 ;;
      cyan) color=6 ;;
      white|*) color=7 ;; # white or invalid color
    esac
  fi
  tput bold;
  tput setaf "$color";
  echo "$arrow $exp";
  tput sgr0;
}

info() {
  coloredEcho "$1" blue "========>"
}

success() {
  coloredEcho "$1" green "========>"
}

error() {
  coloredEcho "$1" red "========>"
}

substep_info() {
  coloredEcho "$1" magenta "===="
}

substep_success() {
  coloredEcho "$1" cyan "===="
}

substep_error() {
  coloredEcho "$1" red "===="
}

#######################################################################
# variables
#######################################################################

function working() {
  cd "$HOME/Developer/Working" || exit
}

function repos() {
  cd "$HOME/Developer/Github" || exit
}

#######################################################################
# open .dotfiles in fzf
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
# fix gh completions
#######################################################################

function __my_op_plugin_run() {
  _op_plugin_run
  for ((i = 2; i < CURRENT; i++)); do
    if [[ ${words[i]} == -- ]]; then
      shift $i words
      ((CURRENT -= i))
      _normal
      return
    fi
  done
}

function __load_op_completion() {
  completion_function="$(op completion zsh)"
  sed -E 's/^( +)_op_plugin_run/\1__my_op_plugin_run/' <<<"${completion_function}"
}

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
# other
#######################################################################

function wttr() {
  curl http://wttr.in/"$1"
}

