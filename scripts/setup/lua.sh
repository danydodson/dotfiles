#!/usr/bin/env bash

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

__info 'Installing luarocks packages...'

luarocks install checks || __err 'failed luarocks install checks'
luarocks --lua-dir=/opt/homebrew/opt/lua@5.1 install metalua-compiler || __err 'failed luarocks install metalua-compiler'
luarocks --lua-dir=/opt/homebrew/opt/lua@5.1 install formatter || __err 'failed luarocks install formatter'
luarocks install lanes || __err 'failed luarocks install lanes'
luarocks --lua-dir=/opt/homebrew/opt/lua@5.3 install lua-lsp || __err 'failed luarocks install lua-lsp'
luarocks install luacheck || __err 'failed luarocks install luacheck'
luarocks install --server=https://luarocks.org/dev argcheck || __err 'failed luarocks install argcheck'
luarocks install busted || __err 'failed luarocks install busted'
luarocks install luacov || __err 'failed luarocks install luacov'

__info 'Finished installing luarocks packages...'
