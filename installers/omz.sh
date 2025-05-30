#!/usr/bin/env bash

# Installs oh-my-zsh

# shellcheck disable=SC1091
. "$HOME/.dotfiles/tools/reports.sh"

set -e
trap on_error SIGTERM

install_ohmyzsh() {
    info "installing ohmyzsh..."

    ZSH="$HOME/.config/ohmyzsh" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git "$ZSH_CUSTOM"/plugins/zsh-autocomplete

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM"/plugins/zsh-syntax-highlighting

    git clone https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM"/plugins/zsh-history-substring-search
    
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

    # git clone https://github.com/sindresorhus/pure.git "$ZSH_CUSTOM/themes/pure"
}

main() {
    install_ohmyzsh "$"
    on_finish "$*"
}

main "$*"
