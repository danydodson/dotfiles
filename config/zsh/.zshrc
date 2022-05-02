# zmodload zsh/zprof

export DOTFILES="$HOME/Dotfiles"

# Functions
source "$DOTFILES"/config/shell/functions.sh

# Settings
source "$DOTFILES"/config/zsh/settings.zsh

# Path
source "$DOTFILES"/config/shell/path.sh

# Exports
source "$DOTFILES"/config/shell/exports.sh

# Aliases
source "$DOTFILES"/config/shell/aliases.sh

# Custom prompt
source "$DOTFILES"/config/zsh/prompt.zsh

# External plugins (initialized after)
source "$DOTFILES"/config/zsh/plugins.zsh

# zprof