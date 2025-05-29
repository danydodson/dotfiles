#!/usr/bin/env zsh

# directories
[ -d $HOME/.dotfiles ] && alias dots="cd $HOME/.dotfiles"
[ -d $HOME/.config/nvim ] && alias nvims="cd $HOME/.config/nvim"
[ -d $HOME/Downloads ] && alias dl="cd $HOME/Downloads"
[ -d $HOME/Games ] && alias games="cd $HOME/Games"
[ -d $HOME/Developer/plugins ] && alias plug="cd $HOME/Developer/plugins"
[ -d $HOME/Developer/practice ] && alias prac="cd $HOME/Developer/practice"
[ -d $HOME/Developer/repos ] && alias repo="cd $HOME/Developer/repos"
[ -d $HOME/Developer/served ] && alias ser="cd $HOME/Developer/served"
[ -d $HOME/Developer/temp ] && alias temp="cd $HOME/Developer/temp"

# create and cd into directory
mkd() {
  mkdir -p $@ && cd ${@:$#}
}

# yazi wrapper
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# change working dir in shell to last dir in lf on exit
lfcd() {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    if [ -d "$dir" ]; then
      if [ "$dir" != "$(pwd)" ]; then
        cd "$dir"
      fi
    fi
  fi
}
bindkey -s '^o' 'lfcd\n'

# nvm autoload node version
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version="$(nvm version "$(<"$nvmrc_path")")"

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
