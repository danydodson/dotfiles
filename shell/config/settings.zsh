#!/usr/bin/env zsh

# custom auto suggestions
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#D19A66"

# ls_colors
export LSCOLORS=ExFxBxDxCxegedabagacad
if [ -f "/opt/homebrew/bin/gdircolors" ]; then
  eval "$(gdircolors -b "${DOTFILES}"/config/lscolors/ls_colors)"
fi

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_history"

# vim
bindkey -v
export KEYTIMEOUT=1

# Options
setopt hist_ignore_space hist_reduce_blanks hist_verify extended_history
setopt inc_append_history hist_ignore_dups hist_expire_dups_first
setopt rm_star_wait print_exit_value auto_name_dirs interactive_comments
setopt autopushd pushd_silent pushd_to_home pushd_ignore_dups pushd_minus autocd cdable_vars
setopt nocaseglob extended_glob glob_complete complete_in_word
setopt menu_complete auto_list auto_menu list_packed auto_param_slash

# Caching completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

# Define completers
zstyle ':completion:*' completer _complete _match _approximate

# Enables interactive menu
zstyle ':completion:*' menu select

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Set colors for different parts of the completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:match:*' group-name ''
zstyle ':completion:*:match:*' file-patterns '*:globbed-files'

# Example specific match colors for groups
# zstyle ':completion:*:corrections' format '%F{yellow}-- %d (errors: %e) --%f'
# zstyle ':completion:*:descriptions' format '%F{blue}-- %D %d --%f'
# zstyle ':completion:*:messages' format ' %F{purple}-- %d --%f'
# zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options false
zstyle ':completion:*' file-sort name

# Ensures the prefix you type is retained
zstyle ':completion:*' keep-prefix true

# completions may gain elevated privileges
zstyle ':completion::complete:*' gain-privileges 1

# Complete alias when _expand_alias is used as a function
zstyle ':completion:*' complete true
zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Enables the completion of hostnames by reading ssh_host and known_hosts files
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# location for completions
zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

# load completions if present
if [ -f $zsh_dump_file ]; then
    compinit -d $zcompdump
fi

# only perform compinit once a day
if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]];
then
    zcompile "$zcompdump"
fi

# ctrl+p runs tms script
bindkey -s '^p' "tms\n"

# ctrl+w new tmux session
bindkey -s '^w' "tmux new\n"

# history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Allows delete key on multiple lines
bindkey -v '^?' backward-delete-char

# Change cursor for diff modes
function zle_keymap_select () {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q';;
    viins|main) echo -ne '\e[5 q';;
  esac
}
zle -N zle_keymap_select

zle_line_init() { 
  echo -ne "\e[5 q" 
}
zle -N zle_line_init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

# Clear back buffer
function clear_shell() {
  printf '\e[3J\e[H\e[2J'
  source "$HOME/.zshrc"
}
alias c='clear_shell'
zle -N clear_shell
bindkey -M viins '^L' clear_shell
bindkey -M vicmd '^L' clear_shell

# Force ctrl+D to close shell
exit_zsh() { 
  exit 
}
zle -N exit_zsh
bindkey '^D' exit_zsh

# Create and change into a new directory
mkcd() {
  mkdir -p $@ && cd ${@:$#}
}

# Switch dirs with ctrl+O
lfcd () {
  tmp="$(mktemp -uq)"
  trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT HUP INT QUIT TERM PWR EXIT'
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
  fi
}
bindkey -s '^o' '^ulfcd\n'
bindkey -s '^a' '^ubc -lq\n'
bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'
bindkey '^[[P' delete-char

# Open editor with ctrl+e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# Yazi file manager
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

