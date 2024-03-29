#!/usr/bin/env bash

# Log Helpers 
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }

function runScripts() {
  # Ask for the administrator password upfront
  sudo -v
   
  # Keep-alive: update existing `sudo` time stamp until the script has finished
  while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

  # Run sections based on command line arguments
  for ARG in "$@"; do
    if [ "$ARG" == "init" ] || [ "$ARG" == "all" ]; then
      __info "Starting init.sh script..."
      ./setup/init.sh
    fi
    if [ "$ARG" == "brew" ] || [ "$ARG" == "all" ]; then
      __info "Starting brew.sh script..."
      ./setup/brew.sh
    fi

    if [ "$ARG" == "pyenv" ] || [ "$ARG" == "all" ]; then
      __info "Starting pyenv.sh script..."
      ./setup/pyenv.sh
    fi
    if [ "$ARG" == "nvm" ] || [ "$ARG" == "all" ]; then
      __info "Starting nvm.sh script..."
      ./setup/nvm.sh
    fi
    if [ "$ARG" == "npm" ] || [ "$ARG" == "all" ]; then
      __info "Starting npm.sh script..."
      ./setup/npm.sh
    fi
    if [ "$ARG" == "yarn" ] || [ "$ARG" == "all" ]; then
      __info "Starting yarn.sh script..."
      ./setup/yarn.sh
    fi
    if [ "$ARG" == "lua" ] || [ "$ARG" == "all" ]; then
      __info "Starting lua.sh script..."
      ./setup/lua.sh
    fi
    if [ "$ARG" == "macos" ] || [ "$ARG" == "all" ]; then
      __info "Starting macos.sh script..."
      ./setup/macos.sh
    fi
    if [ "$ARG" == "config" ] || [ "$ARG" == "all" ]; then
      __info "Starting config.sh script..."
      ./setup/config.sh
    fi
    if [ "$ARG" == "copy" ] || [ "$ARG" == "all" ]; then
      __info "Starting copy.sh script..."
      ./setup/copy.sh
    fi
  done
  __ok "Completed running setup.sh, restart your computer to ensure all updates take effect"
}

read -r -p "This script may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1

echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
  runScripts "$@"
fi

unset runScripts
