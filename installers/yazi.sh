#!/bin/bash

# Set up tmux and install plugins

# shellcheck disable=SC1091
. "$HOME/.dotfiles/tools/reports.sh"

set -e
trap on_error SIGTERM

setup_yazi() {
	if which yazi >/dev/null 2>&1; then
		info "Installing yazi plugins..."

		if [ ! -d "$HOME/.config/yazi/plugins/chmod.yazi" ]; then
			ya pack -a yazi-rs/plugins:chmod
		fi
		if [ ! -d "$HOME/.config/yazi/plugins/duckdb.yazi" ]; then
			ya pack -a wylie102/duckdb
		fi
		if [ ! -d "$HOME/.config/yazi/plugins/exifaudio.yazi" ]; then
			ya pack -a "Sonico98/exifaudio"
		fi
		if [ ! -d "$HOME/.config/yazi/plugins/file-extra-metadata.yazi" ]; then
			ya pack -a boydaihungst/file-extra-metadata
		fi
		if [ ! -d "$HOME/.config/yazi/plugins/full-border.yazi" ]; then
			ya pack -a yazi-rs/plugins:full-border
		fi
		if [ ! -d "$HOME/.config/yazi/plugins/lsar.yazi" ]; then
			ya pack -a yazi-rs/plugins:lsar
		fi
		if [ ! -d "$HOME/.config/yazi/plugins/max-preview.yazi" ]; then
			ya pack -a yazi-rs/plugins:max-preview
		fi
		if [ ! -d "$HOME/.config/yazi/plugins/miller.yazi" ]; then
			ya pack -a Reledia/miller
		fi
		if [ ! -d "$HOME/.config/yazi/plugins/mime-ext.yazi" ]; then
			ya pack -a yazi-rs/plugins:mime-ext
		fi
		if [ ! -d "$HOME/.config/yazi/plugins/no-status.yazi" ]; then
			ya pack -a yazi-rs/plugins:no-status
		fi
		if [ ! -d "$HOME/.config/yazi/plugins/restore.yazi" ]; then
			ya pack -a boydaihungst/restore
		fi
		if [ ! -d "$HOME/.config/yazi/plugins/rich-preview.yazi" ]; then
			ya pack -a AnirudhG07/rich-preview
		fi
		if [ ! -d "$HOME/.config/yazi/plugins/sudo-demo.yazi" ]; then
			ya pack -a yazi-rs/plugins:sudo-demo
		fi
		if [ ! -d "$HOME/.config/yazi/plugins/torrent-preview.yazi" ]; then
			git clone https://github.com/kirasok/torrent-preview.yazi.git ~/.config/yazi/plugins/torrent-preview.yazi
		fi
	fi

	finish
}

main() {
	setup_yazi "$"
	on_finish "$*"
}

main "$*"
