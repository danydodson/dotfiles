#!/bin/bash

# Script which is running daily with crontab
#
# > Add following line to crontab:
# 30 23 * * * /Users/Dany/Developer/Dotfiles/scripts/daily/_cronjob.sh >/tmp/stdout.log 2>/tmp/stderr.log

export PATH=':/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/Dany/.config/local/bin:/opt/homebrew/bin/coreutils/libexec/gnubin:/opt/homebrew/bin/findutils/libexec/gnubin:/opt/homebrew/bin/grep/libexec/gnubin:/opt/homebrew/bin/bc/bin:/opt/homebrew/bin/fzf/bin:/Users/Dany/Developer/Dotfiles/bin'

# Log Helpers
# . "$HOME/Developer/Dotfiles/utils/helpers.sh"
. "$HOME/Developer/Dotfiles/utils/pretty.bash"

date

__info "Running update.sh"
/Users/Dany/Developer/Dotfiles/scripts/daily/update.sh

__info "Running cleanup.sh"
/Users/Dany/Developer/Dotfiles/scripts/daily/cleanup.sh

__info "Running rebuild-github-pages.sh"
/Users/Dany/Developer/Dotfiles/scripts/daily/rebuild.sh

# todo: send mail on error log
