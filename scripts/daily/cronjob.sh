#!/bin/bash

# Script which is running daily with crontab

# > Add following line to crontab:
# 0 */12 * * * /Users/Dany/Developer/Dotfiles/scripts/daily/cronjob.sh >/tmp/stdout.log 2>/tmp/stderr.log

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/bin/coreutils/libexec/gnubin:/opt/homebrew/bin/findutils/libexec/gnubin:/opt/homebrew/bin/grep/libexec/gnubin:/opt/homebrew/bin/bc/bin:/opt/homebrew/bin/fzf/bin:$HOME/Developer/Dotfiles/config/bin:$HOME/.config/iterm2/utils"

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }

date

__info "Running update.sh..."
"$HOME"/Developer/Dotfiles/scripts/daily/update.sh

__info "Running cleanup.sh..."
"$HOME"/Developer/Dotfiles/scripts/daily/cleanup.sh

__info "Running rebuild-github-pages.sh..."
"$HOME"/Developer/Dotfiles/scripts/daily/rebuild.sh

# todo: send mail on error log
