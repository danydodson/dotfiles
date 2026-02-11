#!/usr/bin/env zsh

export CLICOLOR=1

autoload -U colors && colors

# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b"
# 💀

# pure prompt
fpath+=("$HOME/.dotfiles/plugins/pure")

autoload -U promptinit
promptinit

# optionally define some options
PURE_CMD_MAX_EXEC_TIME=10

# turn on git stash status
zstyle :prompt:pure:git:stash show yes

prompt pure
