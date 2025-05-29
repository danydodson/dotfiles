#!/usr/bin/env bash

# Installs sketchybar

# shellcheck disable=SC1091
. "$HOME/.dotfiles/tools/reports.sh"

set -e
trap on_error SIGTERM

setup_sketchybar() {
    install_sketchybar
    finish
}

install_sketchybar() {
    info "installing sketchybar deps..."

    # packages
    brew install lua
    brew install switchaudio-osx
    brew install nowplaying-cli

    brew tap FelixKratz/formulae
    brew install sketchybar

    # fonts
    brew install --cask sf-symbols
    brew install --cask homebrew/cask-fonts/font-sf-mono
    brew install --cask homebrew/cask-fonts/font-sf-pro

    curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.5/sketchybar-app-font.ttf -o "$HOME"/Library/Fonts/sketchybar-app-font.ttf

    # sbarlua
    (git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)

    brew services restart sketchybar
}

main() {
    setup_sketchybar "$"
    on_finish "$*"
}

main "$*"
