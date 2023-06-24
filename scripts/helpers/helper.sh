#!/usr/bin/env bash

#######################################################################
# POSIX-compliant helper scripts
#######################################################################

# silently determine existence of executable
# $1 name of bin
__has() { command -v "$1" >/dev/null 2>&1; }

__prefer() {
  __has "$1" && return 0
  printf "[WARN] %s not found\n" "$1"
  return 1
}

# pipe into this to indent
__indent() { sed 's/^/    /'; }

# require root
__requireroot() {
  [ "$(whoami)" = "root" ] && return 0
  __err "Please run as root, these files go into /etc/**/"
  return 1
}

# require executable
# $1 name of bin
__require() {
  __has "$1" && __info "[FOUND] ${1}" && return 0
  __err "[MISSING] ${1}"
  __err_ "Please install before proceeding."
  return 1
}
