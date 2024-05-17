#!/usr/bin/env bash

# src -> source .zshrc
function src() {
  source ~/.zshrc && printf '\033[0;34m >>> \033[0;34m%s\033[0;m\n' 'source ~/.zshrc'
}

# pi -> ping google dns
function pi() {
  ping -Anc 5 1.1.1.1
}

# dsx -> delete .DS_Store
function dsx() {
  fd -H '^\.DS_Store$' -E '.Trash' -E 'Library' -tf -X trash-put
}

# copy -> copy to clipboard
function copy() {
  printf "%s" "$*" | tr -d "\n" | pbcopy
}

# ygs -> yarn generate and serve
function ygs() {
  yarn generate && http-server dist/ -p 8080
}

# randpass -> generate passwords
function randpass() {
  local len=${1:-32}
  openssl rand -base64 256 | tr -d '\n/+=' | cut -c -"$len"
}

# wttr -> get weather forcaset
function wttr() {
  curl http://wttr.in/"$1"
}

# catr -> tail and head
# function catr() {
#   tail -n "+$1" "$3" | head -n "$(($2 - $1 + 1))"
# }

# validateJson -> validate yaml
function validateYaml() {
  python -c 'import yaml,sys;yaml.safe_load(sys.stdin)' <"$1"
}

# eslintify -> run eslint
function eslintify() {
  cat "$1" >/tmp/file_to_eslint
  npx eslint
}

batman() {
    BAT_THEME="Monokai Extended" command batman "$@"
    return $?
}

# fvim -> find and open a file in vim
function fvim() {
  if [[ $# -eq 0 ]]; then
    fd -t f | fzf --header "Open File in nvim" --preview "bat --color=always {}" | xargs nvim
  else
    fd -t f | fzf --header "Open File in nvim" --preview "bat --color=always {}" -q "$@" | xargs nvim
  fi
}

# vim -> open vim in the current directory or open the target file
# function vim() {
#   if [[ $# -eq 0 ]]; then
#     nvim .
#   else
#     nvim "$@"
#   fi
# }

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

# pa_rm -> remove form path
function path_rm() {
  PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

#  pa_ap -> append to path
function path_ap() {
  path_rm "$1"
  PATH="${PATH:+"$PATH:"}$1"
}

# fp_rm -> remove from fpath
function fpath_rm() {
  FPATH=$(echo -n "$FPATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

# fp_ap -> append to fpath
function fpath_ap() {
  fpath_rm "$1"
  FPATH="${FPATH:+"$FPATH:"}$1"
}
