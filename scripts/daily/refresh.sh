#!/usr/bin/env bash

# Runs daily scripts

date

cd /Users/Dany/Documents/Developer/.dotfiles || exit

/scripts/daily/update.sh
/scripts/daily/clean.sh
/scripts/daily/rebuild.sh

# todo: send mail on error log
