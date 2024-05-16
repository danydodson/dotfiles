# settings.zsh

# history
export HISTFILE="$HOME/.config/cache/zsh/zsh_history"
export LESSHISTFILE="$HOME/.config/cache/less/lesshst"
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HIST_STAMPS=yyyy-mm-dd

setopt EXTENDED_HISTORY         # write in the ":start:elapsed;command" format
setopt APPEND_HISTORY           # append to the history file, don't overwrite it
setopt HIST_EXPIRE_DUPS_FIRST   # expire duplicates first when trimming history
setopt HIST_FIND_NO_DUPS        # do not display duplicates in history
setopt HIST_IGNORE_ALL_DUPS     # delete old recorded duplicates
setopt HIST_IGNORE_SPACE        # ignore commands starting with a space
setopt HIST_SAVE_NO_DUPS        # do not save duplicates
setopt HIST_REDUCE_BLANKS       # remove superfluous blanks before recording
setopt INC_APPEND_HISTORY       # write after each command
setopt SHARE_HISTORY            # share history between sessions
setopt HIST_VERIFY              # check the history file for consistency

# changing dirs
setopt AUTO_PUSHD               # push the directory onto the directory stack after cd
setopt PUSHD_IGNORE_DUPS        # do not push multiple copies of the same directory onto the directory stack
setopt PUSHD_SILENT             # do not print the directory stack after pushd or popd
setopt PUSHD_TO_HOME            # push the home directory onto the directory stack when no argument is given to cd

# list comps
setopt AUTO_LIST                # automatically list choices on an ambiguous completion
setopt AUTO_MENU                # automatically use menu completion after the second consecutive request for completion
setopt NO_COMPLETE_ALIASES      # do not complete aliases
setopt LIST_PACKED              # do not expand the list of completions

# expand and glob
setopt EXTENDED_GLOB            # use extended globbing

# autocomp aliases
setopt ALIASES                  # expand aliases
setopt AUTO_PARAM_SLASH         # automatically slash the last parameter on a command line
setopt CORRECT                  # correct the spelling of commands

# job control
setopt CHECK_JOBS               # check for terminated background jobs immediately
setopt LONGLISTJOBS             # list jobs in long format
setopt NO_HUP                   # do not kill jobs on shell exit

# allow in prompt
setopt PROMPT_SUBST             # allow command substitution in prompts
setopt INTERACTIVE_COMMENTS     # allow comments in interactive shell

# zsh options
unsetopt menu_complete     # do not autoselect the first completion entry
unsetopt flow_control      # disable start/stop characters in shell editor
unsetopt case_glob         # makes globbing (filename generation) case-sensitive 

setopt always_to_end       # move cursor to the end of a completed word
setopt auto_menu           # show completion menu on a successive tab press
setopt auto_list           # automatically list choices on ambiguous completion
setopt auto_param_slash    # if completed parameter is a directory, add a trailing slash
setopt complete_in_word    # complete from both ends of a word
setopt extended_glob       # needed for file modification glob modifiers with compinit
setopt path_dirs           # perform path search even on command names with slashes
setopt globdots            # files beginning with a . be matched without explicitly specifying the dot

# color complist
zmodload -i zsh/complist
autoload -Uz colors && colors

# hooks -- used for prompt too
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

# automatically fix things when pasted
autoload -Uz bracketed-paste-magic 
zle -N bracketed-paste bracketed-paste-magic

# automatically quote URLs as they are typed
autoload -Uz url-quote-magic 
zle -N self-insert url-quote-magic 

# group matches and describe
# https://thevaluable.dev/zsh-completion-guide-examples/
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' list-dirs-first yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' expand yes
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'
zstyle ':completion:*:*:-redirect-,2>,*:*' file-patterns '*.log'

# completion caching
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $HOME/.config/cache/zsh/zcompcache

# fuzzy match mistyped completions
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# directories
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

# ignores unavailable commands
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)'

# completion element sorting
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# history
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# ignore multiple entries
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'
