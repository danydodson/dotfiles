# settings.zsh

export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

#######################################################################
# History                                                             #
#######################################################################

HISTSIZE=50000
SAVEHIST=50000
HISTFILE="${HOME}/.config/cache/zsh/zsh_history"
LESSHISTFILE="${HOME}/.config/cache/less/lesshst"
SHELL_SESSIONS_DISABLE=1

#######################################################################
# Completions                                                         #
#######################################################################

zcompdump="${ZDOTDIR:-$HOME/.config/zsh}/.zcompdump_${SHORT_HOST}_${ZSH_VERSION}"

if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
  zcompile "$zcompdump"
fi

#######################################################################
# Options
#######################################################################

# disable ^S and ^Q terminal freezing
unsetopt flowcontrol

# Changing Directories
setopt AUTO_PUSHD # pushd instead of cd
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT # hide stack after cd
setopt PUSHD_TO_HOME # go home if no d specified

# Completion
setopt AUTO_LIST # list completions
setopt AUTO_MENU # TABx2 to start a tab complete menu
setopt NO_COMPLETE_ALIASES # no expand aliases before completion
setopt LIST_PACKED  # variable column widths

# Expansion and Globbing
setopt EXTENDED_GLOB # like ** for recursive dirs

# History
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY # append instead of overwrite file
setopt EXTENDED_HISTORY # extended timestamps
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE # omit from history if space prefixed
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY # verify when using history cmds/params

# Input/Output
setopt ALIASES # autocomplete switches for aliases
setopt AUTO_PARAM_SLASH # append slash if autocompleting a dir
setopt CORRECT

# Job Control
setopt CHECK_JOBS # prompt before exiting shell with bg job
setopt LONGLISTJOBS # display PID when suspending bg as well
setopt NO_HUP # do not kill bg processes

# Prompting
setopt PROMPT_SUBST # allow variables in prompt

# Shell Emulation
setopt INTERACTIVE_COMMENTS # allow comments in shell

# Zle
setopt NO_BEEP

#######################################################################
# Modules
#######################################################################

# color complist
zmodload -i zsh/complist
autoload -Uz colors; colors

# hooks -- used for prompt too
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

# automatically fix things when pasted, works with url-quote-magic
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# automatically quote URLs as they are typed
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#######################################################################
# Keybindings
# These keys should also be set in shell/.inputrc
#
# `cat -e` to test out keys
#
# \e is the same as ^[ is the escape code for <Esc>
# Prefer ^[ since it mixes better with the letter form [A
#
# Tested on macbook iterm2 and magic keyboard+arch, xterm-256color
# - Need both normal mode and vicmd mode
#######################################################################

# VI mode
bindkey -v

#######################################################################
# Keybindings - Completion with tab
# Cancel and reset prompt with ctrl-c
#######################################################################

# shift-tab to select previous result
bindkey -M menuselect '^[[Z' reverse-menu-complete

# fix prompt (and side-effect of exiting menuselect) on ^C
bindkey -M menuselect '^C' reset-prompt

#######################################################################
# Keybindings - Movement keys
#######################################################################

# Home/Fn-Left
bindkey '^[[H' beginning-of-line
bindkey -M vicmd '^[[H' beginning-of-line

# End/Fn-Right
bindkey '^[[F' end-of-line
bindkey -M vicmd '^[[F' end-of-line

# Left and right should jump through words
# Opt-Left
bindkey '^[[H' backward-word
bindkey -M vicmd '^[[H' backward-word
# Opt-Right
bindkey '^[[F' forward-word
bindkey -M vicmd '^[[F' forward-word
# Ctl-Left
bindkey '^[[1;5D' vi-backward-word
bindkey -M vicmd '^[[1;5D' vi-backward-word
# Ctl-Right
bindkey '^[[1;5C' vi-forward-word
bindkey -M vicmd '^[[1;5C' vi-forward-word

#######################################################################
# Keybindings: Editing keys
#######################################################################

# fix delete - Fn-delete
# Don't bind in vicmd mode
bindkey '^[[3~' delete-char

# Allow using backspace from :normal [A]ppend
bindkey -M viins '^?' backward-delete-char

#######################################################################
# Keybindings: History navigation
# Don't bind in vicmd mode, so I can edit multiline commands properly.
#######################################################################

# Up/Down search history filtered using already entered contents
# bindkey '^[[A' history-search-backward
# bindkey '^[[B' history-search-forward

# PgUp/Dn navigate through history like regular up/down
# bindkey '^[[5~' up-history
# bindkey '^[[6~' down-history

#######################################################################
# Keybindings: Movement, also triggers zsh-autosuggest partials
#######################################################################

bindkey '^e' vi-forward-word-end
bindkey '^w' vi-forward-word

#######################################################################
# Completion: Caching
#######################################################################

zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path $HOME/.config/zsh

#######################################################################
# Completion: Display
#######################################################################

# group all by the description above
zstyle ':completion:*' group-name ''

# colorful completion
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# list dirs first
zstyle ':completion:*' list-dirs-first yes

# go into menu mode on second tab (like current vim wildmenu setting)
# only if there's more than two things to choose from
zstyle ':completion:*' menu select=2

# show descriptions for options
zstyle ':completion:*' verbose yes

# in Bold, specify what type the completion is, e.g. a file or an alias or a cmd
zstyle ':completion:*:descriptions' format '%F{black}%B%d%b%f'

#######################################################################
# Completion: Output transformation
#######################################################################

# expand completions as much as possible on tab
# e.g. start expanding a path up to wherever it can be until error
zstyle ':completion:*' expand yes

# process names
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# colorful kill command completion -- probably overridden by fzf
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# complete .log filenames if redirecting stderr
zstyle ':completion:*:*:-redirect-,2>,*:*' file-patterns '*.log'

#######################################################################
# Completion: Matching
#######################################################################

# use case-insensitive completion if case-sensitive generated no hits
zstyle ':completion:*' matcher-list \
  z'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# don't complete usernames
zstyle ':completion:*' users ''

# don't autocomplete homedirs
zstyle ':completion::complete:cd:*' tag-order '! users'

#######################################################################
# Oh-my-zsh plugins
#######################################################################

zstyle ':omz:plugins:nvm' lazy yes
