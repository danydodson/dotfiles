#!/usr/bin/env zsh

# history file
export HISTFILE="$HOME/.zsh_history" # Sets the file where history is saved
export HISTSIZE=1000000000 # Sets maximum history entries in memory
export SAVEHIST=$HISTSIZE # Sets maximum history entries in file

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

# disable pattern matching
# unsetopt extendedglob # Disable extended globbing so that ^ will behave as normal

# history search
bindkey '^[[A' history-substring-search-up # up arrow for searching history backwards
bindkey '^[[B' history-substring-search-down  # down arrow for searching history forwards

# vim keymaps history search
bindkey -M vicmd 'k' history-substring-search-up # vim 'k' key for searching history backwards
bindkey -M vicmd 'j' history-substring-search-down # vim 'j' key for searching history forwards

# lscolors
export CLICOLOR=1
# export LSCOLORS=ExFxBxDxCxegedabagacad
if [ -f "/opt/homebrew/bin/gdircolors" ]; then
  eval "$(gdircolors -b "${DOTFILES}"/config/lscolors/ls_colors)"
fi

# suggestion color
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555555"

# complist and colors
zmodload -i zsh/complist # Loads the completion system module
autoload -Uz colors && colors # Enables color support in the shell

# enable gnu ls in macOS
zstyle ':omz:lib:theme-and-appearance' gnu-ls yes # Uses GNU ls formatting in MacOS

# use passphase from macos keychain
if [[ "$OSTYPE" == "darwin"* ]]; then
  zstyle :omz:plugins:ssh-agent ssh-add-args --apple-load-keychain
fi

# completion menu and grouping settings
zstyle ':completion:*:*:*:*:*' menu select # Enables interactive menu for completions
zstyle ':completion:*:matches' group yes # Groups similar matches together
zstyle ':completion:*:options' description yes # Shows descriptions for options
zstyle ':completion:*:options' auto-description '%d' # Automatic descriptions for options

# formatting for different completion messages
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f' # Format for corrections
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f' # set descriptions format to enable group support
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f' # Format for messages
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f' # Format for no matches
zstyle ':completion:*:default' list-prompt '%S%M matches%s' # Format for match count

# general completion behavior
zstyle ':completion:*' format ' %F{yellow}-- %d --%f' # Configures how completion headers appear in the shell
zstyle ':completion:*' list-dirs-first yes # Lists directories first
zstyle ':completion:*' group-name '' # Groups completions by name
zstyle ':completion:*' verbose yes # Shows detailed completion info
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' # Case-insensitive matching
zstyle ':completion:*' expand yes # Expands aliases before completing
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq' # Process completion
zstyle ':completion:*:*:-redirect-,2>,*:*' file-patterns '*.log' # Log file completion for redirections

# caching completions
zstyle ':completion:*' use-cache on # Enables completion caching
zstyle ':completion:*' cache-path ${ZSH}/cache # Sets cache location

# fuzzy matching settings
zstyle ':completion:*' completer _complete _match _approximate  # Enables fuzzy matching
zstyle ':completion:*:match:*' original only # Only shows original matches
zstyle ':completion:*:approximate:*' max-errors 1 numeric # Allows 1 error in completion

# directory and color settings
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # Uses ls colors for completion
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories # Directory completion order
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select # Directory stack menu
zstyle ':completion:*:-tilde-:*' group-order 'path-directories' 'named-directories' 'users' 'expand' # Tilde completion order
zstyle ':completion:*' squeeze-slashes true # Combines multiple slashes

# function and parameter handling
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)' # Ignores certain functions
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters # Subscript completion order

# manual page settings
zstyle ':completion:*:manuals' separate-sections true # Separates manual sections
zstyle ':completion:*:manuals.(^1*)' insert-sections true # Inserts section headers

# history completion settings
zstyle ':completion:*:history-words' stop yes # Enables history word completion
zstyle ':completion:*:history-words' remove-all-dups yes # Removes duplicates
zstyle ':completion:*:history-words' list false # Disables listing
zstyle ':completion:*:history-words' menu yes # Enables menu

# multiple entry handling
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other # Ignores current line for certain commands
zstyle ':completion:*:rm:*' file-patterns '*:all-files' # File patterns for rm command

# location for completions
zcompdump="${HOME}/.zcompdump"

# load completions if present
if [ -f $zsh_dump_file ]; then
    compinit -d $zcompdump
fi

# only perform compinit once a day
if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]];
then
    zcompile "$zcompdump"
fi

