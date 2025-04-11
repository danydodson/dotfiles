#!/bin/bash

# Set up tmux and install plugins

# shellcheck disable=SC1091
. "$HOME/.dotfiles/tools/reports.sh"

set -e
trap on_error SIGTERM

install_tmux() {
	case $(uname) in
	Darwin)
		if ! which tmux >/dev/null 2>&1; then
			info "Install tmux via Brewfile on macOS."
		fi
		install_tmux_plugins
		;;
	Linux)
		if ! which tmux >/dev/null 2>&1; then
			info "Install tmux ßvia Brewfile on linux."
		fi
		install_tmux_plugins
		;;
	*) ;;
	esac

	finish
}

install_tmux_plugins() {
	if [ ! -d "$HOME"/.tmux/plugins ]; then
		info 'Creating dir ~/.tmux/plugins...'
		mkdir -p "$HOME"/.tmux/plugins
	fi

	if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
		git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
	fi
	if [ ! -d "$HOME/.tmux/plugins/tmux-1password" ]; then
		git clone https://github.com/yardnsm/tmux-1password "$HOME/.tmux/plugins/tmux-1password"
	fi
	if [ ! -d "$HOME/.tmux/plugins/tmux-sensible" ]; then
		git clone https://github.com/tmux-plugins/tmux-sensible "$HOME/.tmux/plugins/tmux-sensible"
	fi
	if [ ! -d "$HOME/.tmux/plugins/tmux-continuum" ]; then
		git clone https://github.com/tmux-plugins/tmux-continuum "$HOME/.tmux/plugins/tmux-continuum"
	fi
	if [ ! -d "$HOME/.tmux/plugins/tmux-resurrect" ]; then
		git clone https://github.com/tmux-plugins/tmux-resurrect "$HOME/.tmux/plugins/tmux-resurrect"
	fi
	if [ ! -d "$HOME/.tmux/plugins/vim-tmux-navigator" ]; then
		git clone https://github.com/christoomey/vim-tmux-navigator "$HOME/.tmux/plugins/vim-tmux-navigator"
	fi
	if [ ! -d "$HOME/.tmux/plugins/better-vim-tmux-resizer" ]; then
		git clone https://github.com/RyanMillerC/better-vim-tmux-resizer "$HOME/.tmux/plugins/better-vim-tmux-resizer"
	fi
	if [ ! -d "$HOME/.tmux/plugins/minimal-tmux-status" ]; then
		git clone https://github.com/niksingh710/minimal-tmux-status "$HOME/.tmux/plugins/minimal-tmux-status"
	fi

	info "to finish the installation, install all plugins with <prefix> + I in tmux."
}

main() {
	install_tmux "$"
	on_finish "$*"
}

main "$*"
