# Prompt configurations

DEFAULT_USER=$(whoami)

ZSH_THEME="powerlevel10k/powerlevel10k"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f "${DOTFILES}/zsh/.p10k.zsh" ]] || source "${DOTFILES}/zsh/.p10k.zsh"
