#!/usr/bin/env bash

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }

# Install global yarn packages

__info 'Installing yarn global packages...'
yarn global add gatsby-cli || __err 'failed yarn global add gatsby-cli'
yarn global add @angular/cli || __err 'failed yarn global add @angular/cli'
