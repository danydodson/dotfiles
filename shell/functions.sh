#!/usr/bin/env bash

# dots -> cd to .dotfiles
function dots() {
  cd "$HOME/.dotfiles/" || exit
}

# config -> cd to .config
function config() {
  cd "$HOME/.config/" || exit
}

# dev -> cd to dev
function dev() {
  cd "$HOME/Developer/" || exit
}

# working -> cd to working
function working() {
  cd "$HOME/Developer/Working/" || exit
}

# repos -> cd to github
function repos() {
  cd "$HOME/Developer/Github/" || exit
}

# nvconf -> cd to config/nvim
function nvconf() {
  nvim "$HOME/.config/nvim/"
}

# path-remove -> remove form path
function path-remove() {
  PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

#  path-append -> append to path
function path-append() {
  path-remove "$1"
  PATH="${PATH:+"$PATH:"}$1"
}

# path -> prepend to path
function path-prepend() {
  path-remove "$1"
  PATH="$1${PATH:+":$PATH"}"
}

# fpath -> remove from fpath
function fpath-remove() {
  FPATH=$(echo -n "$FPATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

# fpath -> append to fpath
function fpath-append() {
  fpath-remove "$1"
  FPATH="${FPATH:+"$FPATH:"}$1"
}

# fpath -> prepend to fpath
function fpath-prepend() {
  path-remove "$1"
  FPATH="$1${FPATH:+":$FPATH"}"
}

# dsx -> delete .DS_Store
function dsx() {
  find . -name "*.DS_Store" -type f -delete
}

# pi -> ping google dns
function pi() {
  ping -Anc 5 1.1.1.1
}

# ygs -> yarn generate and serve
function ygs() {
  yarn generate && http-server dist/ -p 8080
}

# randpw -> generate random password
function randpw() {
  openssl rand -base64 4 | md5 | head -c"$1"
  echo
}

# randpass -> generate passwords
randpass() {
  local len=${1:-32}
  openssl rand -base64 256 | tr -d '\n/+=' | cut -c -"$len"
}

# copy -> copy to clipboard
copy() {
  printf "%s" "$*" | tr -d "\n" | pbcopy
}

# wttr -> get weather forcaset
function wttr() {
  curl http://wttr.in/"$1"
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
function vim() {
  if [[ $# -eq 0 ]]; then
    nvim .
  else
    nvim "$@"
  fi
}

# bubo -> brew update and outdated
function bubo() {
  brew update && brew outdated
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

# bb -> bundle brewfile
function bb() {
  if [ -e "$HOME"/.dotfiles/config/brew/Brewfile ]; then
    echo "-> Bundling Brewfile located at $HOME/.dotfiles/config/brew/Brewfile"
    sleep 2
    brew bundle --file "$HOME"/.dotfiles/config/brew/Brewfile
  else
    echo "Brewfile not found."
  fi
}

# bbc -> bundle brewfile cleanup
function bbc() {
  if [ -e "$HOME"/.dotfiles/config/brew/Brewfile ]; then
    echo "-> Running bundle cleanup dry-run for Brewfile located at $HOME/.dotfiles/config/brew/Brewfile"
    sleep 2
    brew bundle cleanup --file "$HOME"/.dotfiles/config/brew/Brewfile
  else
    echo "Brewfile not found."
  fi
}

# bbcf -> bundle brewfile cleanup force
function bbcf() {
  if [ -e "$HOME"/.dotfiles/config/brew/Brewfile ]; then
    echo "-> Running bundle cleanup (force) for Brewfile located at $HOME/.dotfiles/config/brew/Brewfile"
    sleep 2
    brew bundle cleanup --force --file "$HOME"/.dotfiles/config/brew/Brewfile
  else
    echo "Brewfile not found."
  fi
}
