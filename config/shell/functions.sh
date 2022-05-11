#!/bin/bash

_info() {
  echo -e "\033[36m[INFO]\033[0m $1"
}

_ok() {
  echo -e "\033[32m[OK]\033[0m $1"
}

function up() {
  _file="$HOME/Dotfiles/config/zsh/.zshrc"
  _info "Copying $_file to $HOME ..."
  cp -p "$_file" "$HOME" && _ok "Copied $_file to $HOME"
}

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

function rmds() {
  _info "Removing all .DS_Store files from $(pwd)..."
  find . -name '*.DS_Store' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;
}

function rmtrash() {
  _info "Removing all trash files..."
  sudo rm -frv /Volumes/*/.Trashes sudo rm -frv ~/.Trash sudo rm -frv /private/var/log/asl/*.asl
}

function finm() {
  _info "Finding node_modules folders from $(pwd)..."
  find . -name "node_modules" -print0 -type d -prune | xargs du -chs
}

function rmnm() {
  _info "Removing node_modules folders from $(pwd)..."
  find . -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;
}

function rmdnm() {
  _info "Removing node_modules from ~/Developer..."
  find ~/Developer -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;
}

function wttr() {
  curl http://wttr.in/"$1"
}

function ipinf0() {
  curl http://ipinfo.io/"$1"
}

function yt() {
  yt-dlp "$1" -o "$HOME/Movies/Web/%(title)s.%(ext)s"
}

function here() {
  local loc
  if [ "$#" -eq 1 ]; then
    loc=$(realpath "$1")
  else
    loc=$(realpath ".")
  fi
  ln -sfn "${loc}" "$HOME/.shell.here"
  _info "here -> $(readlink "$HOME"/.shell.here)"
}

there="$HOME/.shell.here"

function there() {
  cd "$(readlink "${there}")" || exit
}

function mkcd() {
  mkdir -p "$@" && cd "$_" || exit
}

function fid-cd() {
  local dir
  dir=$(find "${1:-.}" -type d 2>/dev/null | fzf +m) && cd "$dir" || exit
}

function appify() {
  _APPNAME=${2:-$(basename "$1" ".sh")}
  _DIR="$_APPNAME.app/Contents/MacOS"
  if [ -a "$_APPNAME.app" ]; then
    _info "$PWD/$_APPNAME.app already exists :("
  fi
  if [[ $_APPNAME == '' || $_DIR == '' ]]; then
    _info "Appify requires two parameters bash script and app name"
    _info "Usage : appify myscript.sh myapp"
  else
    mkdir -p "$_DIR"
    cp "$1" "$_DIR/$_APPNAME"
    chmod +x "$_DIR/$_APPNAME"
    _info "$PWD/$_APPNAME.app"
  fi
}

function fzf-sl() {
  _SCRIPTS_PATH="$HOME/Dotfiles/scripts/"

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
