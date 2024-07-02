#!/bin/zsh

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE

export HISTFILE="$HOME/.config/cache/zsh/zsh_history"
export LESSHISTFILE="$HOME/.config/cache/less/lesshst"

setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

