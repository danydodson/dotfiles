#!/usr/bin/env bash

# Runs daily scripts

date

cd /Users/Dany/.dotfiles || exit

/Users/Dany/.dotfiles/scripts/daily/update.sh
/Users/Dany/.dotfiles/scripts/daily/clean.sh

# todo: send mail on error log
