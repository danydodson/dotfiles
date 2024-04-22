# settings.zsh

# direnv -> used with instant prompt
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

# instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.config/cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.config/cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# direnv -> used with instant prompt
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

# completion dump
zcompdump="${ZDOTDIR:-$HOME/.config/zsh}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
  zcompile "$zcompdump"
fi

# history
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export HISTFILE="${HOME}/.config/cache/zsh/zsh_history"
export LESSHISTFILE="${HOME}/.config/cache/less/lesshst"
export HIST_STAMPS="yyyy-mm-dd"

# disable freezing
# unsetopt flowcontrol

# VI mode
# bindkey -v

# history
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY
setopt HIST_VERIFY

# changing dirs
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME

# list comps
setopt AUTO_LIST
setopt AUTO_MENU
setopt NO_COMPLETE_ALIASES
setopt LIST_PACKED

# expand and glob
setopt EXTENDED_GLOB

# autocomp aliases
setopt ALIASES
setopt AUTO_PARAM_SLASH
setopt CORRECT

# job control
setopt CHECK_JOBS
setopt LONGLISTJOBS
setopt NO_HUP

# allow vars in prompt
setopt PROMPT_SUBST

# allow comments in shell
setopt INTERACTIVE_COMMENTS

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

# Completion: Caching
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "$HOME/.config/cache/zsh"

# group all by the description above
zstyle ':completion:*' group-name ''

# list dirs first
zstyle ':completion:*' list-dirs-first yes

# show descriptions for options
zstyle ':completion:*' verbose yes

# in Bold, specify what type the completion is, e.g. a file or an alias or a cmd
zstyle ':completion:*:descriptions' format '%F{black}%B%d%b%f'

# expand completions as much as possible on tab
zstyle ':completion:*' expand yes

# process names
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# complete .log filenames if redirecting stderr
zstyle ':completion:*:*:-redirect-,2>,*:*' file-patterns '*.log'

# colorful completion
zstyle ':completion:*:default' list-colors \
  "di=1;36" ".mp4=01;93" ".dmg=0;35" ".zip=0;35" ".mp3=01;93" \
  "ln=01;36" "so=32" "pi=33" "ex=0;32" "bd=34;46" "cd=34;43" \
  "su=30;41" "sg=30;46" "tw=30;42" "ow=30;43"
