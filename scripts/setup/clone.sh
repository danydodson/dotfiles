#!/bin/bash
# shellcheck disable=SC2015

# Clone github repositories to local machine

echo ''

# Log Helper
_info() { echo -e "\033[36m[INFO]\033[0m $1"; }
_ok() { echo -e "\033[32m[OK]\033[0m $1"; }
_error() { echo -e "\033[31m[ERROR]\033[0m $1"; }

_info "Cloning repositories..."

# Served sites
SERVED=$HOME/Developer/Served

git clone git@github.com:danydodson/danydodson-dev.git "$SERVED"/danydodson-dev && _ok '' || _error "Failed to clone danydodson-dev"
