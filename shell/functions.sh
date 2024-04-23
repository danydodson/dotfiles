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
# function nvconf() {
#   nvim "$HOME/.config/nvim/"
# }

# src -> source .zshrc
function src() {
  # shellcheck disable=SC1090
  source ~/.zshrc && echo 'source ~/.zshrc'
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

# bathelp -> pretty print help
alias bathelp='bat --plain --language=help'
function help() {
  "$@" --help 2>&1 | bathelp
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

# randpass -> generate passwords
function randpass() {
  local len=${1:-32}
  openssl rand -base64 256 | tr -d '\n/+=' | cut -c -"$len"
}

# copy -> copy to clipboard
function copy() {
  printf "%s" "$*" | tr -d "\n" | pbcopy
}

# wttr -> get weather forcaset
function wttr() {
  curl http://wttr.in/"$1"
}

# catr -> tail and head
function catr() {
  tail -n "+$1" "$3" | head -n "$(($2 - $1 + 1))"
}

# validateJson -> validate yaml
function validateYaml() {
  python -c 'import yaml,sys;yaml.safe_load(sys.stdin)' <"$1"
}

# eslintify -> run eslint
function eslintify() {
  cat "$1" >/tmp/file_to_eslint
  npx eslint
}

# fvim -> find and open a file in vim
# function fvim() {
#   if [[ $# -eq 0 ]]; then
#     fd -t f | fzf --header "Open File in nvim" --preview "bat --color=always {}" | xargs nvim
#   else
#     fd -t f | fzf --header "Open File in nvim" --preview "bat --color=always {}" -q "$@" | xargs nvim
#   fi
# }

# vim -> open vim in the current directory or open the target file
# function vim() {
#   if [[ $# -eq 0 ]]; then
#     nvim .
#   else
#     nvim "$@"
#   fi
# }

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
