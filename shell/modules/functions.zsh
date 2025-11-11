#!/usr/bin/env zsh

# Create and change into a new directory
# >
# 
mkcd() {
  mkdir -p $@ && cd ${@:$#}
}

# Get the Bundle ID of a macOS app
# > i.e. bundleid terminal
# 
bundleid() {
  local ID=$( osascript -e 'id of app "'"$1"'"' )
  if [ ! -z $ID ]; then
    echo $ID | tr -d '[:space:]' | pbcopy
    echo "$ID (copied to clipboard)"
  fi
}


# 
# >
# 
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# 
# >
# 
sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(
      sesh list -t -c \
        --icons | fzf-tmux -p 80%,70% \
        --no-sort \
        --ansi \
        --border \
        --prompt '⚡' \
        --header '' \
        --bind 'tab:down,btab:up' \
        --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
        --bind 'ctrl-t:change-prompt(   )+reload(sesh list -t --icons)' \
        --bind 'ctrl-c:change-prompt(⛭  )+reload(sesh list -c --icons)' \
        --bind 'ctrl-z:change-prompt(  )+reload(sesh list -z --icons)' \
        --bind 'ctrl-f:change-prompt(  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
        --preview 'sesh preview {}'
    )
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}
zle -N sesh-sessions

# 
# >
# 
paths() {
  local blue="\e[34m"
  local green="\e[32m"
  local yellow="\e[0;93m"
  local red="\e[31m"
  local reset="\e[0m"

  for dir in ${(s.:.)PATH}; do
    if [[ -d "$dir" ]]; then
      echo "${green}✓${reset} ${blue}$dir${reset}"
    else
      echo "${red}✗${reset} $dir"
    fi
  done
}

# 
# >
# 
fpaths() {
  local blue="\e[34m"
  local green="\e[32m"
  local yellow="\e[0;93m"
  local red="\e[31m"
  local reset="\e[0m"

  for dir in ${(s.:.)FPATH}; do
    if [[ -d "$dir" ]]; then
      echo "${green}✓${reset} ${blue}$dir${reset}"
    else
      echo "${red}✗${reset} $dir"
    fi
  done
}

# 
# >
# 
macos_paths() {
  local blue="\e[34m"
  local green="\e[32m"
  local yellow="\e[0;93m"
  local red="\e[31m"
  local reset="\e[0m"

  local macos_path
  macos_path=$(launchctl getenv PATH)

  for dir in ${(s.:.)PATH}; do
    if [[ -d "$dir" ]]; then
      echo "${green}✓${reset} ${blue}$dir${reset}"
    else
      echo "${red}✗${reset} $dir"
    fi
  done
}

# 
# >
# 
manpaths() {
  local blue="\e[34m"
  local green="\e[32m"
  local yellow="\e[0;93m"
  local red="\e[31m"
  local reset="\e[0m"

  for dir in ${(s.:.)MANPATH}; do
    if [[ -d "$dir" ]]; then
      echo "${green}✓${reset} ${blue}$dir${reset}"
    else
      echo "${red}✗${reset} $dir"
    fi
  done
}

