# 

DEFAULT_USER=$(whoami)

ZSH_THEME="powerlevel10k/powerlevel10k"

# instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.config/cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.config/cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# run -> p10k configure
[[ ! -f ~/.dotfiles/prompt/p10k.zsh ]] || source ~/.dotfiles/prompt/p10k.zsh

# completion dump
zcompdump="${ZDOTDIR:-$HOME/.config/zsh}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
  zcompile "$zcompdump"
fi

# consistent ls and zsh completion colouring
export CLICOLOR=1
# export LSCOLORS="exfxcxdxbxegedabagacad"
# export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"