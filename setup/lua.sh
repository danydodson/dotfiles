#!/bin/bash

# This scripts installs Lua, LuaRocks, and some Lua libraries on macOS.
# The main purpose is to install Busted for testing Neovim plugins.
# After the installation, you will be able to run test using busted:
#   busted --lua nlua spec/mytest_spec.lua

. "$HOME/.dotfiles/bin/reports"

################################################################################
# Dependencies
################################################################################

xcode-select --install

# Lua Directory: where Lua and Luarocks will be installed
LUA_DIR="$HOME/.config/lua"
mkdir -p $LUA_DIR

# LuaRocks Directory: where LuaRocks will install rocks (Lua libraries)
LUAROCKS_DIR="$HOME/.config/luarocks"
mkdir -p $LUAROCKS_DIR

################################################################################
# Lua
################################################################################

# Download and Extract Lua Sources
cd /tmp
rm -rf lua-5.1.5.*
wget https://www.lua.org/ftp/lua-5.1.5.tar.gz
LUA_SHA='2640fc56a795f29d28ef15e13c34a47e223960b0240e8cb0a82d9b0738695333'
shasum -a 256 lua-5.1.5.tar.gz | grep -q $LUA_SHA && info "Hash matches" || echo "Hash don't match"
tar xvf lua-5.1.5.tar.gz
cd lua-5.1.5/

# Modify Makefile to set destination dir
sed -i '' "s#/usr/local#${LUA_DIR}/#g" Makefile

# Compile and install Lua
make macosx
make test && make install

# Export PATHs
export PATH="$PATH:$LUA_DIR/bin"
export LUA_CPATH="$LUA_DIR/lib/lua/5.1/?.so"
export LUA_PATH="$LUA_DIR/share/lua/5.1/?.lua;;"
export MANPATH="$LUA_DIR/share/man:$MANPATH"

# Verify Lua Installation
which lua
info "Expected Output:"
info "  ${LUA_DIR}/bin/lua"
lua -v
info 'Expected Output:'
info '  Lua 5.1.5  Copyright (C) 1994-2012 Lua.org, PUC-Rio'
file ${LUA_DIR}/bin/lua
info "Expected Output (on Apple Silicon):"
info "  ${LUA_DIR}/bin/lua: Mach-O 64-bit executable arm64"

################################################################################
# LuaRocks
################################################################################

# Download and Extract LuaRocks Sources
cd /tmp
rm -rf luarocks-3.9.1.*
wget https://luarocks.org/releases/luarocks-3.9.1.tar.gz
tar xvf luarocks-3.9.1.tar.gz
cd luarocks-3.9.1/

# Configure LuaRocks installation
./configure --rocks-tree="${LUAROCKS_DIR}" --prefix="${LUA_DIR}" --with-lua="${LUA_DIR}" --with-lua-include="${LUA_DIR}/include" --lua-suffix=5.1

# Compile and install LuaRocks
make build && make install

# Export PATHs
export PATH="$PATH:$LUAROCKS_DIR/bin"

# Verify LuaRocks installation
luarocks --version
info 'Expected Output: '
info "  ${LUA_DIR}/bin/luarocks 3.9.1"
info "  LuaRocks main command-line interface"

################################################################################
# LuaSec (with luarocks)
################################################################################

# Ensure OpenSSL is installed - for example via Homebrew: `brew install openssl`

# Add external dependencies directory to LuaRocks config
echo 'external_deps_dirs = { "/opt/homebrew" }' >>"${LUA_DIR}/etc/luarocks/config-5.1.lua"

# Find the latest version of OpenSSL
OPENSSL_PREFIX=$(brew --prefix openssl@3)
OPENSSL_INCDIR="${OPENSSL_PREFIX}/include"
OPENSSL_LIBDIR="${OPENSSL_PREFIX}/lib"

# Install LuaSec rock
luarocks --tree="${LUAROCKS_DIR}" --local install luasec \
  OPENSSL_INCDIR=$OPENSSL_INCDIR \
  OPENSSL_LIBDIR=$OPENSSL_LIBDIR

################################################################################
# nlua (with luarocks)
################################################################################

# Install nlua rock
luarocks --tree="${LUAROCKS_DIR}" --local install nlua

# Verify nlua installation
info "print(1 + 2)" | nlua
info 'Expected Output: '
info '  3'

################################################################################
# Busted (with luarocks)
################################################################################

# Install busted rock
luarocks --tree="${LUAROCKS_DIR}" --local install busted

# Export PATHs
eval "$(luarocks path --no-bin)"

################################################################################
# post-installation
################################################################################

# echo '--------------------------------------------------------------------------------'
# echo "Add the following lines to .bashrc or .zshrc"
# echo ''
# echo '# Lua'
# echo "export LUA_DIR=${LUA_DIR}"
# echo 'export PATH="$PATH:${LUA_DIR}/bin"'
# echo 'export LUA_CPATH="${LUA_DIR}/lib/lua/5.1/?.so"'
# echo 'export LUA_PATH="${LUA_DIR}/share/lua/5.1/?.lua;;"'
# echo 'export MANPATH="${LUA_DIR}/share/man:$MANPATH"'
# echo ''
# echo '# LuaRocks'
# echo 'export PATH="$PATH:$HOME/.luarocks/bin"'
# echo 'eval $(luarocks path --no-bin)'

# ################################################################################
# ################################################################################
# # Lua Uninstall
# ################################################################################

# # Download and Extract Lua Sources
# cd /tmp
# wget https://www.lua.org/ftp/lua-5.1.5.tar.gz
# LUA_SHA='2640fc56a795f29d28ef15e13c34a47e223960b0240e8cb0a82d9b0738695333'
# shasum -a 256 lua-5.1.5.tar.gz | grep -q $LUA_SHA && info "Hash matches" || echo "Hash don't match"
# tar xvf lua-5.1.5.tar.gz
# cd lua-5.1.5/

# # Modify Makefile to set destination dir
# sed -i '' "s#/usr/local#${LUA_DIR}/#g" Makefile

# # Compile and install Lua
# make macosx
# make test && make uninstall

# ################################################################################
# # LuaRocks
# ################################################################################

# # Download and Extract LuaRocks Sources
# cd /tmp
# wget https://luarocks.org/releases/luarocks-3.9.1.tar.gz
# tar xvf luarocks-3.9.1.tar.gz
# cd luarocks-3.9.1/

# # Configure LuaRocks installation
# ./configure \
#   --prefix=${LUA_DIR} \
#   --with-lua=${LUA_DIR} \
#   --with-lua-include=${LUA_DIR}/include \
#   --lua-suffix=5.1

# # Compile and install LuaRocks
# make build && make uninstall

# rm -rf "$HOME/.luarocks"
# rm -rf "$HOME/.config/luarocks"

# ################################################################################
# # Remove directories
# ################################################################################

# rm -rf "$LUA_DIR"
# rm -rf "$HOME/.luarocks"
# rm -rf "$HOME/.config/luarocks"

# ################################################################################
# # Post Unistallation
# ################################################################################

# # echo ''
# # echo '--------------------------------------------------------------------------------'
# # echo "Remove the following lines from .bashrc or .zshrc"
# # echo ''
# # echo '# Lua'
# # echo "export LUA_DIR=${LUA_DIR}"
# # echo 'export PATH="$PATH:${LUA_DIR}/bin"'
# # echo 'export LUA_CPATH="${LUA_DIR}/lib/lua/5.1/?.so"'
# # echo 'export LUA_PATH="${LUA_DIR}/share/lua/5.1/?.lua;;"'
# # echo 'export MANPATH="${LUA_DIR}/share/man:$MANPATH"'
# # echo ''
# # echo '# LuaRocks'
# # echo 'export PATH="$PATH:$HOME/.luarocks/bin"'
# # echo 'eval $(luarocks path --no-bin)'
