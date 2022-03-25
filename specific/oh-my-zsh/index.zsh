export XDG_CACHE_HOME=~/.cache

export ZSH=~/.config/ohmyzsh
export ZDOTDIR=~/.config/zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
DEFAULT_USER=$(whoami)

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

plugins=(gh node npm brew docker docker-compose git)

source $ZSH/oh-my-zsh.sh

source $ZDOTDIR/iterm2_shell_integration.zsh

eval "$(fnm env --use-on-cd)"