#!/bin/bash

# Clone github repositories to local machine

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }

__info "Cloning repositories..."

# Served directory
served_dir=$HOME/Developer/Served

# Sites to clone
served=(
  danydodson-dev
  danydodson.github.io
)

for site in "${served[@]}"; do
  if [ ! -d "$served_dir/$site" ]; then
    __info "Cloning $site to $served_dir"
    gh repo clone "danydodson/$site" "$served_dir/$site" && __ok "Cloned $site"
  fi
done
