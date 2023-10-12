#!/usr/bin/env bash

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

__info 'Installing lua packages...'

luarocks install checks || __err 'failed luarocks install checks'
luarocks install lanes || __err 'failed luarocks install lanes'
luarocks install luacheck || __err 'failed luarocks install luacheck'
luarocks install busted || __err 'failed luarocks install busted'
luarocks install luacov || __err 'failed luarocks install luacov'

__info 'Finished installing lua packages...'
