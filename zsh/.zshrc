# vim:syntax=zsh
# vim:filetype=zsh

zmodload zsh/zprof

export DOTFILES="${HOME}/.dotfiles"

# functions
source "${DOTFILES}"/shell/functions.sh

# prompt
source "${DOTFILES}"/zsh/prompt.zsh

# exports
source "${DOTFILES}"/shell/exports.sh

# plugins
source "${DOTFILES}"/zsh/plugins.zsh

# settings
source "${DOTFILES}"/zsh/settings.zsh

# aliases
source "${DOTFILES}"/shell/aliases.sh
