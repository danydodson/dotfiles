#!/bin/bash

# Runs daily scripts

date

dir=/Users/Dany/Documents/Developer/.dotfiles/scripts/daily

cd $dir || exit

"$dir"/update.sh
"$dir"/clean.sh
"$dir"/rebuild.sh

# todo: send mail on error log
