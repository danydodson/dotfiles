#!/usr/bin/env zsh

# custom auto suggestions
export ZSH_AUTOSUGGEST_USE_ASYNC=true
# export ZSH_HIGHLIGHT_MAXLENGTH=200
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#D19A66"

# ls_colors
export LSCOLORS=ExFxBxDxCxegedabagacad
if [ -f "/opt/homebrew/bin/gdircolors" ]; then
  eval "$(gdircolors -b "${DOTFILES}"/config/lscolors/ls_colors)"
fi

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_history"

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

# history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# vim
bindkey -v
export KEYTIMEOUT=1

# Vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor for diff modes
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;
        viins|main) echo -ne '\e[5 q';;
    esac
}
zle -N zle-keymap-select

zle-line-init() {
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

