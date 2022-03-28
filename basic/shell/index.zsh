# xdg
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# zsh
export ZDOTDIR="$HOME/.config/zsh"
export ZSH_CACHE_DIR="$HOME/.cache/zsh"

# oh-my-zsh
export ZSH="$XDG_CONFIG_HOME/ohmyzsh"

# node
export FNM_DIR="${XDG_DATA_HOME}/fnm"

# ruby
export RBENV_ROOT="$HOME/.local/rbenv"

# python
export PYENV_ROOT="$HOME/.local/pyenv"

# iTerm2
export ITERM2_CONFIG="$HOME/.config/iterm2"

# homebrew
export HOMEBREW_NO_ENV_HINTS=false

# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# yarn
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME/yarn"

# wakatime
export WAKATIME_HOME="$XDG_DATA_HOME/wakatime"

# $path
export PATH="${PYENV_ROOT}/bin:${PATH}"
export PATH="$RBENV_ROOT/bin:$PATH"
export PATH="$RBENV_ROOT/shims:${PATH}"
export PATH="./bin:/opt/homebrew/bin:/usr/local/bin:$DOTFILES/basic/bin:$PATH"

# config
# export LSCOLORS="exfxcxdxbxegedabagacad"
# export CLICOLOR=true

fpath=($DOTFILES/basic/functions $fpath)

autoload -U $DOTFILES/basic/functions/*(:t)

HISTSIZE=10000
SAVEHIST=10000

setopt NO_BG_NICE
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

setopt complete_aliases

bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[5D' beginning-of-line
bindkey '^[[5C' end-of-line
bindkey '^[[3~' delete-char
bindkey '^?' backward-delete-char

# window title
# From http://dotfiles.org/~_why/.zshrc
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\" # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2\a" # plain xterm title ($3 for pwd)
    ;;
  esac
}

# completion
# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# customizations
source $DOTFILES/basic/shell/custom.sh
