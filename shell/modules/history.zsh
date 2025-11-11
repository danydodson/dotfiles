#!/usr/bin/env zsh

#   ____ ___  __  __ ____  _     _____ _____ ___ ___  _   _ 
#  / ___/ _ \|  \/  |  _ \| |   | ____|_   _|_ _/ _ \| \ | |
# | |  | | | | |\/| | |_) | |   |  _|   | |  | | | | |  \| |
# | |__| |_| | |  | |  __/| |___| |___  | |  | | |_| | |\  |
#  \____\___/|_|  |_|_|   |_____|_____| |_| |___\___/|_| \_|
#

# history file
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_history" # sets the file where history is saved
export HISTSIZE=1000000000 # sets maximum history entries in memory
export SAVEHIST=$HISTSIZE # sets maximum history entries in file

# history configs
setopt EXTENDED_HISTORY # saves timestamp and duration for commands
setopt SHARE_HISTORY # shares history across multiple zsh sessions
setopt HIST_IGNORE_SPACE # ignores commands that start with a space
setopt HIST_SAVE_NO_DUPS # prevents duplicate entries from being saved
setopt HIST_REDUCE_BLANKS # removes extra blank spaces from commands