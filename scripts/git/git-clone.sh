#!/bin/bash

# Clone github repositories to local machine

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }

__info "Cloning repositories..."

# Served sites
__served=$HOME/Developer/Served

git clone git@github.com:danydodson/danydodson-dev.git "$__served"/danydodson-dev && __ok ''
