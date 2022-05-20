#!/bin/bash

# Script which is running daily with crontab
#
# > Add following line to crontab:
# 30 23 * * * /Users/Dany/Developer/Dotfiles/scripts/daily/_cronjob.sh >/tmp/stdout.log 2>/tmp/stderr.log

export PATH=':/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/Dany/.config/local/bin:/opt/homebrew/bin/coreutils/libexec/gnubin:/opt/homebrew/bin/findutils/libexec/gnubin:/opt/homebrew/bin/grep/libexec/gnubin:/opt/homebrew/bin/bc/bin:/opt/homebrew/bin/fzf/bin:/Users/Dany/Developer/Dotfiles/bin'

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }

date

__info "Running update.sh"
/Users/Dany/Developer/Dotfiles/scripts/daily/update.sh

__info "Running cleanup.sh"
/Users/Dany/Developer/Dotfiles/scripts/daily/cleanup.sh

__info "Running rebuild-github-pages.sh"
/Users/Dany/Developer/Dotfiles/scripts/daily/rebuild.sh

# todo: send mail on error log
