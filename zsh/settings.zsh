#!/usr/bin/env zsh

# history file
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zsh_history" # sets the file where history is saved
export HISTSIZE=1000000000 # sets maximum history entries in memory
export SAVEHIST=$HISTSIZE # sets maximum history entries in file

# history configs
setopt EXTENDED_HISTORY # saves timestamp and duration for commands
setopt SHARE_HISTORY # shares history across multiple zsh sessions
setopt HIST_EXPIRE_DUPS_FIRST # removes duplicate commands first when trimming history
setopt HIST_FIND_NO_DUPS # skips duplicate entries when searching history
setopt HIST_IGNORE_ALL_DUPS # removes older duplicate entries in history
setopt HIST_IGNORE_SPACE # ignores commands that start with a space
setopt HIST_SAVE_NO_DUPS # prevents duplicate entries from being saved
setopt HIST_REDUCE_BLANKS # removes extra blank spaces from commands
setopt HIST_VERIFY # shows history expansion before executing

# history search
bindkey '^[[A' history-substring-search-up # up arrow for searching history backwards
bindkey '^[[B' history-substring-search-down  # down arrow for searching history forwards

# vim keymaps history search
bindkey -M vicmd 'k' history-substring-search-up # vim 'k' key for searching history backwards
bindkey -M vicmd 'j' history-substring-search-down # vim 'j' key for searching history forwards

# lscolors
export LSCOLORS=ExFxBxDxCxegedabagacad
if [ -f "/opt/homebrew/bin/gdircolors" ]; then
  eval "$(gdircolors -b "${DOTFILES}"/config/lscolors/ls_colors)"
fi

# suggestion color
# export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#D19A66"

# complist & colors
zmodload -i zsh/complist # loads the completion system module
autoload -Uz colors && colors # enables color support in the shell

# completion menu and grouping settings
zstyle ':completion:*:*:*:*:*' menu select # enables interactive menu for completions
zstyle ':completion:*:matches' group yes # groups similar matches together
zstyle ':completion:*:options' description yes # shows descriptions for options
zstyle ':completion:*:options' auto-description '%d' # automatic descriptions for options

# formatting for different completion messages
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f' # format for corrections
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f' # set descriptions format to enable group support
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f' # format for messages
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f' # format for no matches
zstyle ':completion:*:default' list-prompt '%S%M matches%s' # format for match count

# general completion behavior
zstyle ':completion:*' format ' %F{yellow}-- %d --%f' # configures how completion headers appear in the shell
zstyle ':completion:*' list-dirs-first yes # lists directories first
zstyle ':completion:*' group-name '' # groups completions by name
zstyle ':completion:*' verbose yes # shows detailed completion info
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' # case-insensitive matching
zstyle ':completion:*' expand yes # expands aliases before completing
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq' # process completion
zstyle ':completion:*:*:-redirect-,2>,*:*' file-patterns '*.log' # log file completion for redirections

# caching completions
zstyle ':completion:*' use-cache on # enables completion caching
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" # sets cache location

# fuzzy matching settings
zstyle ':completion:*' completer _complete _match _approximate  # enables fuzzy matching
zstyle ':completion:*:match:*' original only # only shows original matches
zstyle ':completion:*:approximate:*' max-errors 1 numeric # allows 1 error in completion

# directory and color settings
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # uses ls colors for completion
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories # directory completion order
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select # directory stack menu
zstyle ':completion:*:-tilde-:*' group-order 'path-directories' 'named-directories' 'users' 'expand' # tilde completion order
zstyle ':completion:*' squeeze-slashes true # combines multiple slashes

# function and parameter handling
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)' # ignores certain functions
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters # subscript completion order

# manual page settings
zstyle ':completion:*:manuals' separate-sections true # separates manual sections
zstyle ':completion:*:manuals.(^1*)' insert-sections true # inserts section headers

# history completion settings
zstyle ':completion:*:history-words' stop yes # enables history word completion
zstyle ':completion:*:history-words' remove-all-dups yes # removes duplicates
zstyle ':completion:*:history-words' list false # disables listing
zstyle ':completion:*:history-words' menu yes # enables menu

# multiple entry handling
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other # ignores current line for certain commands
zstyle ':completion:*:rm:*' file-patterns '*:all-files' # file patterns for rm command

# enable gnu ls in macOS
zstyle ':omz:lib:theme-and-appearance' gnu-ls yes

# use passphase from macos keychain
if [[ "$OSTYPE" == "darwin"* ]]; then
  zstyle :omz:plugins:ssh-agent ssh-add-args --apple-load-keychain
fi

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
