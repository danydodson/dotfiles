#!/usr/bin/env zsh

# enable colors
export CLICOLOR=1

# pure prompt
fpath+=("$HOME/.dotfiles/plugins/pure")

autoload -U promptinit; promptinit

# optionally define some options
PURE_CMD_MAX_EXEC_TIME=10

# change the path color
# zstyle :prompt:pure:path color '#FF0000'

# change the color for both `prompt:success` and `prompt:error`
# zstyle ':prompt:pure:prompt:*' color cyan

# turn on git stash status
zstyle :prompt:pure:git:stash show yes

prompt pure
