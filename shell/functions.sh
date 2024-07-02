#!/usr/bin/env bash

function dots() {
  cd ~/.dotfiles/ && nvim
}

function nvconf() {
  cd ~/.config/nvim/ && nvim
}

# batr -> tail and head
function battail() {
  tail -n "+$1" "$3" | head -n "$(($2 - $1 + 1))"
}

# rmdss -> delete .DS_Store
function rmdss() {
  find . -name ".DS_Store" -type f -delete
}

# copy -> copy to clipboard
function copy() {
  printf "%s" "$*" | tr -d "\n" | pbcopy
}

# randpass -> generate passwords
function randpass() {
  local len=${1:-32}
  openssl rand -base64 256 | tr -d '\n/+=' | cut -c -"$len"
}

# vf -> find and open a file in nvim
function vf() {
  if [[ $# -eq 0 ]]; then
    fd -t f | fzf --header "Open File in nvim" --walker-skip=.git,node_modules,target,Library,Pictures,Documents,Music,.Trash --ansi --no-bold --preview "bat --color=always {}" | xargs nvim
  else
    fd -t f | fzf --header "Open File in nvim" --walker-skip=.git,node_modules,target,Library,Pictures,Documents,Music,.Trash --ansi --no-bold --preview "bat --color=always {}" -q "$@" | xargs nvim
  fi
}

zle -N vf vf
bindkey "^[v" vf

# batman -> bat with theme
function batman() {
  BAT_THEME="Monokai Extended" command batman "$@"
  return $?
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
