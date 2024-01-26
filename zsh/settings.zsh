# settings.zsh

export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

# history
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="${HOME}/.config/cache/zsh/zsh_history"
LESSHISTFILE="${HOME}/.config/cache/less/lesshst"
SHELL_SESSIONS_DISABLE=1

# completion dump
zcompdump="${ZDOTDIR:-$HOME/.config/zsh}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
  zcompile "$zcompdump"
fi

# disable ^S and ^Q terminal freezing
unsetopt flowcontrol

# changing directories
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME

# list completions
setopt AUTO_LIST
setopt AUTO_MENU
setopt NO_COMPLETE_ALIASES
setopt LIST_PACKED

# expand and glob
setopt EXTENDED_GLOB

# history
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# autocomplete switches for aliases
setopt ALIASES
setopt AUTO_PARAM_SLASH
setopt CORRECT

# job control
setopt CHECK_JOBS
setopt LONGLISTJOBS
setopt NO_HUP

# allow variables in prompt
setopt PROMPT_SUBST

# allow comments in shell
setopt INTERACTIVE_COMMENTS

# zle
setopt NO_BEEP

# color complist
zmodload -i zsh/complist
autoload -Uz colors
colors

# hooks -- used for prompt too
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

# automatically fix things when pasted
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# automatically quote URLs as they are typed
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# nvm plugin for oh-my-zsh
zstyle ':omz:plugins:nvm' lazy yes

# VI mode
bindkey -v

# Don't bind in vicmd mode
bindkey '^[[3~' delete-char

# Allow using backspace from :normal [A]ppend
bindkey -M viins '^?' backward-delete-char

# Up/Down search history-substring plugin
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey '^e' vi-forward-word-end
bindkey '^w' vi-forward-word

# Completion: Caching
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path $HOME/.config/cache/zsh

# group all by the description above
zstyle ':completion:*' group-name ''

# # colorful completion
zstyle ':completion:*:default' list-colors \
  "di=1;36" ".mp4=01;93" ".dmg=0;35" ".zip=0;35" ".mp3=01;93" \
  "ln=01;36" "so=32" "pi=33" "ex=0;32" "bd=34;46" "cd=34;43" \
  "su=30;41" "sg=30;46" "tw=30;42" "ow=30;43"

# # list dirs first
zstyle ':completion:*' list-dirs-first yes

# go into menu mode on second tab (like current vim wildmenu setting)
# only if there's more than two things to choose from
zstyle ':completion:*' menu select=2

# show descriptions for options
zstyle ':completion:*' verbose yes

# in Bold, specify what type the completion is, e.g. a file or an alias or a cmd
zstyle ':completion:*:descriptions' format '%F{black}%B%d%b%f'

# expand completions as much as possible on tab
# e.g. start expanding a path up to wherever it can be until error
zstyle ':completion:*' expand yes

# process names
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# colorful kill command completion -- probably overridden by fzf
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# complete .log filenames if redirecting stderr
zstyle ':completion:*:*:-redirect-,2>,*:*' file-patterns '*.log'

# use case-insensitive completion if case-sensitive generated no hits
zstyle ':completion:*' matcher-list \
  z'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# # don't complete usernames
zstyle ':completion:*' users ''

# # don't autocomplete homedirs
zstyle ':completion::complete:cd:*' tag-order '! users'
