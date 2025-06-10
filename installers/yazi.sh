#!/usr/bin/env bash

# Installs yazi plugins

# shellcheck disable=SC1091
. "$HOME/.dotfiles/tools/reports.sh"

set -e
trap on_error SIGTERM

setup_yazi() {
    if which yazi >/dev/null 2>&1; then
        info "Installing yazi plugins..."

        if [ ! -d "$HOME/.config/yazi/plugins/chmod.yazi" ]; then
            ya pkg add yazi-rs/plugins:chmod
        fi
        if [ ! -d "$HOME/.config/yazi/plugins/exifaudio.yazi" ]; then
            ya pkg add "Sonico98/exifaudio"
        fi
        if [ ! -d "$HOME/.config/yazi/plugins/file-extra-metadata.yazi" ]; then
            ya pkg add boydaihungst/file-extra-metadata
        fi
        if [ ! -d "$HOME/.config/yazi/plugins/lsar.yazi" ]; then
            ya pkg add yazi-rs/plugins:lsar
        fi
        if [ ! -d "$HOME/.config/yazi/plugins/sudo-demo.yazi" ]; then
            ya pkg add yazi-rs/plugins:sudo-demo
        fi
        if [ ! -d "$HOME/.config/yazi/plugins/mime-ext.yazi" ]; then
            ya pkg add yazi-rs/plugins:mime-ext
        fi
        if [ ! -d "$HOME/.config/yazi/plugins/torrent-preview.yazi" ]; then
            git clone https://github.com/kirasok/torrent-preview.yazi.git ~/.config/yazi/plugins/torrent-preview.yazi
        fi
    else
        error "Error: ya pkg is not available"
    fi

    finish
}

main() {
    setup_yazi "$"
}

main "$*"
