#!/usr/bin/env bash

# Runs daily scripts

date

cd "$HOME"/.dotfiles || return

/Users/Dany/.dotfiles/scripts/daily/update.sh
/Users/Dany/.dotfiles/scripts/daily/clean.sh
