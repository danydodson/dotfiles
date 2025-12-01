#!/bin/bash

# Set base download directory
BASE_DIR=~/Downloads/trgui

# Create the base folder if it doesn't exist
mkdir -p "$BASE_DIR"

# The download URL
URL="https://github.com/openscopeproject/TrguiNG/releases/download/v1.4.0/trguing-web-v1.4.0.zip"

# Get the filename
FILENAME=$(basename "$URL")

cd "$BASE_DIR"

# Download the file
curl -L -o "$FILENAME" "$URL"

# Unzip into public_html (removes previous if exists)
rm -rf public_html
mkdir public_html
unzip -q "$FILENAME" -d public_html

# Target directory for Transmission's web folder
TX_DIR="/opt/homebrew/opt/transmission-cli/share/transmission"

# Backup old public_html
if [ -d "$TX_DIR/public_html" ]; then
    mv "$TX_DIR/public_html" "$TX_DIR/public_html_backed"
fi

# Move new public_html into place
mv -f "$BASE_DIR/public_html" "$TX_DIR/public_html"

echo "Done! New web UI deployed to $TX_DIR/public_html"