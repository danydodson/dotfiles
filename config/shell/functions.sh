#!/bin/bash

_info() {
  echo -e "\033[36m[INFO]\033[0m $1"
}

_ok() {
  echo -e "\033[32m[OK]\033[0m $1"
}

up() {
  _file="$HOME/Dotfiles/config/zsh/.zshrc"
  _info "Copying $_file to $HOME ..."
  cp -p "$_file" $HOME && _ok "Copied $_file to $HOME"
}

path_remove() {
  PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

path_append() {
  path_remove "$1"
  PATH="${PATH:+"$PATH:"}$1"
}

path_prepend() {
  path_remove "$1"
  PATH="$1${PATH:+":$PATH"}"
}

fpath_remove() {
  fpath=$(echo -n "$fpath" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

fpath_append() {
  fpath_remove "$1"
  fpath="${FPATH:+"$fpath:"}$1"
}

fpath_prepend() {
  fpath_remove "$1"
  fpath="$1${FPATH:+":$fpath"}"
}

bup() {
  _info "Cleaning Homebrew..."
  brew update && brew upgrade && brew cleanup --prune=all -s && brew doctor
}

rmds() {
  _info "Removing all .DS_Store files from $(pwd)..."
  find . -name '*.DS_Store' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;
}

rmtrash() {
  _info "Removing all trash files..."
  sudo rm -frv /Volumes/*/.Trashes sudo rm -frv ~/.Trash sudo rm -frv /private/var/log/asl/*.asl
}

finm() {
  _info "Finding node_modules folders from $(pwd)..."
  find . -name "node_modules" -type d -prune | xargs du -chs
}

rmnm() {
  _info "Removing node_modules folders from $(pwd)..."
  find . -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;
}

rmdnm() {
  _info "Removing node_modules from ~/Developer..."
  find ~/Developer -name 'node_modules' -type d -prune -exec echo '{}' \; -exec rm -rf {} \;
}

wttr() {
  curl http://wttr.in/$1
}

# helpful ip stats
ipinf0() {
  curl http://ipinfo.io/$1
}

yt() {
  yt-dlp $1 -o "~/Movies/Web/%(title)s.%(ext)s"
}

wifi_pass() {
  _airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
  _ssid=$("$_airport" -I | awk '/ SSID/ {print substr($0, index($0, $2))}')
  _pw=$(security find-generic-password -D 'AirPort network password' -ga "$_ssid" 2>&1 >/dev/null)
  _info $(_info "$_pw" | sed -e "s/^.*\"\(.*\)\".*$/\1/")
}

here() {
  local loc
  if [ "$#" -eq 1 ]; then
    loc=$(realpath "$1")
  else
    loc=$(realpath ".")
  fi
  ln -sfn "${loc}" "$HOME/.shell.here"
  _info "here -> $(readlink $HOME/.shell.here)"
}

there="$HOME/.shell.here"

there() {
  cd "$(readlink "${there}")"
}

cd_finder() {
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

mkd_cd() {
  mkdir -p "$@" && cd "$_"
}

fid_cd() {
  local dir
  dir=$(find ${1:-.} -type d 2>/dev/null | fzf +m) && cd "$dir"
}

appify() {
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

# ctrl-x
# fzf_sl() {
#   _SCRIPTS_PATH="$HOME/Dotfiles/scripts/"

#   _allfiles=$(rg -t sh --files "$_SCRIPTS_PATH")
#   # _filteredfiles=$(echo "$_allfiles" | grep -v "_templates/\|setup/")
#   # _cutpaths=$(echo "$_filteredfiles" | cut -c 30-)
#   _cutpaths=$(echo "$_allfiles" | cut -c 30-)

#   local selected
#   if selected=$(echo "$_cutpaths" | fzf --height 40% --preview "bat --style=grid --color=always '$_SCRIPTS_PATH{}'" -q "$LBUFFER"); then
#     LBUFFER="$_SCRIPTS_PATH$selected"
#   fi
#   zle redisplay
# }

# keybinding
# zle -N fzf_sl
# bindkey '^X' fzf_sl
