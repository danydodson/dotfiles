#!/usr/bin/env zsh

# pure prompt
fpath+=("$HOME/.dotfiles/plugins/pure")

autoload -U promptinit
promptinit

# optionally define some options
PURE_CMD_MAX_EXEC_TIME=10

# turn on git stash status
zstyle :prompt:pure:git:stash show yes

prompt pure
