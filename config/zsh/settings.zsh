# settings.zsh

export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export DOTFILES="$HOME"/Developer/Dotfiles

#######################################################################
# p10k configure                                                      #
#######################################################################

# Code that may require console input must go above this block
if [[ -r ${XDG_CACHE_HOME/zsh:-$HOME/.config/zsh}/p10k-instant-prompt-'${(%):-%n}'.zsh ]]; then
  source ${XDG_CACHE_HOME/zsh:-$HOME/.config/zsh}/p10k-instant-prompt-'${(%):-%n}'.zsh
fi

[[ ! -f "$DOTFILES/config/zsh/p10k.zsh" ]] || source "$DOTFILES/config/zsh/p10k.zsh"

#######################################################################
# Completions                                                         #
#######################################################################

zcompdump="${ZDOTDIR:-$HOME/.config/zsh}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"

if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
  zcompile "$zcompdump"
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' insert-tab pending
zstyle ':completion:*' menu select

#######################################################################
# Key Bindings                                                        #
#######################################################################

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

#######################################################################
# History                                                             #
#######################################################################

HISTSIZE=50000
SAVEHIST=50000
HISTFILE="$HOME/.config/zsh/zsh_history"

setopt hist_verify
setopt hist_reduce_blanks
setopt hist_ignore_all_dups
setopt append_history
setopt share_history
setopt extended_history
setopt inc_append_history

#######################################################################
# Setopts                                                             #
#######################################################################

setopt no_bg_nice
setopt no_hup
setopt no_list_beep
setopt prompt_subst
setopt local_traps
setopt local_options
setopt correct
setopt ignore_eof
setopt complete_in_word
setopt complete_aliases
