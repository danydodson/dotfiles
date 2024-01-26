#!/usr/bin/env bash

# path -> remove
function path-remove() {
  PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

# path -> append
function path-append() {
  path-remove "$1"
  PATH="${PATH:+"$PATH:"}$1"
}

# path -> prepend
function path-prepend() {
  path-remove "$1"
  PATH="$1${PATH:+":$PATH"}"
}

# fpath -> remove
function fpath-remove() {
  FPATH=$(echo -n "$FPATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

# fpath -> append
function fpath-append() {
  fpath-remove "$1"
  FPATH="${FPATH:+"$FPATH:"}$1"
}

# fpath -> prepend
function fpath-prepend() {
  path-remove "$1"
  FPATH="$1${FPATH:+":$FPATH"}"
}

# working -> cd to working directory
function working() {
  cd "$HOME/Developer/Working" || exit
}

# repos -> cd to github directory
function repos() {
  cd "$HOME/Developer/Github" || exit
}

# repos -> cd to apps directory
function apps() {
  cd "$HOME/Developer/Apps" || exit
}

# fvim -> find and open a file in vim
function fvim() {
  if [[ $# -eq 0 ]]; then
    fd -t f | fzf --header "Open File in Vim" --preview "bat --color=always {}" | xargs nvim
  else
    fd -t f | fzf --header "Open File in Vim" --preview "bat --color=always {}" -q "$@" | xargs nvim
  fi
}

# vim -> open vim in the current directory or open the target file
function vim() {
  if [[ $# -eq 0 ]]; then
    nvim .
  else
    nvim "$@"
  fi
}

# randpass -> generate passwords
randpass() {
  local len=${1:-32}
  openssl rand -base64 256 | tr -d '\n/+=' | cut -c -"$len"
}

# wttr -> get weather forcaset
function wttr() {
  curl http://wttr.in/"$1"
}

# __my_op_plugin_run -> fixes op completion
function __my_op_plugin_run() {
  _op_plugin_run

  for ((i = 2; i < CURRENT; i++)); do
    # shellcheck disable=SC2116,SC2154
    if [[ ${words[i]} == -- ]]; then
      shift $i words
      ((CURRENT -= i))
      _normal
      return
    fi
  done

}

# __load_op_completion -> fixes op completion
function __load_op_completion() {
  completion_function="$(op completion zsh)"
  sed -E 's/^( +)_op_plugin_run/\1__my_op_plugin_run/' <<<"${completion_function}"
}

# custom colored prompt
coloredEcho() {
  local exp="$1"
  local color="$2"
  local arrow="$3"
  if ! [[ $color =~ ^[0-9]$ ]]; then
    case $(echo "$color" | tr '[:upper:]' '[:lower:]') in
    black) color=0 ;;
    red) color=1 ;;
    green) color=2 ;;
    yellow) color=3 ;;
    blue) color=4 ;;
    magenta) color=5 ;;
    cyan) color=6 ;;
    white | *) color=7 ;;
    esac
  fi
  tput bold
  tput setaf "$color"
  echo "$arrow $exp"
  tput sgr0
}

# info -> output blue
info() {
  coloredEcho "$1" blue "========>"
}

# success -> output green
success() {
  coloredEcho "$1" green "========>"
}

# error -> output red
error() {
  coloredEcho "$1" red "========>"
}

# substep_info -> output magenta
substep_info() {
  coloredEcho "$1" magenta "===="
}

# substep_success -> output cyan
substep_success() {
  coloredEcho "$1" cyan "===="
}

# substep_error -> output red
substep_error() {
  coloredEcho "$1" red "===="
}
