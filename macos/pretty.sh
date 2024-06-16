#!/usr/bin/env bash

# std logging

__echo() { printf ' %s\033[0;m\n' "$1"; }

__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__info_() { printf '\033[0;34m %s\033[0;m\n' "$1"; }

__user() { printf '\033[0;35m[USER] \033[0;35m%s\033[0;m\n' "$1"; }
__user_() { printf '\033[0;35m %s\033[0;m\n' "$1"; }

__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__ok_() { printf '\033[0;36m %s\033[0;m\n' "$1"; }

__warn() { printf '\033[0;32m[WARN] \033[0;32m%s\033[0;m\n' "$1"; }
__warn_() { printf '\033[0;32m %s\033[0;m\n' "$1"; }

__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }
__err_() { printf '\033[0;31m %s\033[0;m\n' "$1"; }

__warning() { printf '\033[0;32m[WARNING] %s\033[0;m\n' "$1" >&2; }
__warning_() { printf '\033[0;32m %s\033[0;m\n' "$1" >&2; }

__error() { printf '\033[31m[ERROR]\033[0m %s\n' "$1" >&2; }
__error_() { printf '\033[0;31m %s\033[0;m\n' "$1" >&2; }
