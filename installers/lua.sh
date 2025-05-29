#!/usr/bin/env bash

# Installs lua 5.1

# shellcheck disable=SC1091
. "$HOME/.dotfiles/tools/reports.sh"

set -e
trap on_error SIGTERM

LUA_DIR="$HOME/.local/share/lua"

# Create directory; handle errors more robustly.
mkdir -p "$LUA_DIR" || error "Failed to create Lua directory: $LUA_DIR"

# Download Lua; use a more robust download method.
URL="https://www.lua.org/ftp/lua-5.1.5.tar.gz"
wget -q -O "$LUA_DIR/lua-5.1.5.tar.gz" "$URL" || error "Failed to download Lua: $URL"

# Remove extended attributes (if any)
xattr -c "$LUA_DIR/lua-5.1.5.tar.gz" || error "Failed to remove extended attributes"

# Extract the archive; use a more robust method
tar -xzf "$LUA_DIR/lua-5.1.5.tar.gz" -C "$LUA_DIR" || rror "Failed to extract Lua archive"

# Simplified path handling
cd "$LUA_DIR/lua-5.1.5" || errror "Failed to change directory"

# Build and install; improved error handling and clarity
make macosx install INSTALL_TOP="$LUA_DIR" || error "Failed to build and install Lua"

# Clean up the downloaded archive
rm "$LUA_DIR/lua-5.1.5.tar.gz" || error "Failed to remove lua zip"

finish
