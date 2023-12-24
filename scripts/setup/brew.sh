#!/usr/bin/env bash

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Oh-My-Zsh
###############################################################################

# __info 'Installing oh-my-zsh...'
# if [ -e ~/.config/local/share/oh-my-zsh/oh-my-zsh.sh ]; then
#   __ok 'Oh-My-Zsh is already installed...'
# else
#   __info 'cloning...'
#   git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.config/local/share/oh-my-zsh && __ok 'cloned to ~/.config/local/share/oh-my-zsh'
# fi

# __info 'Downloading spaceship prompt...'
# if [ -e "$HOME"/.config/local/share/oh-my-zsh/custom/themes/spaceship.zsh-theme ]; then
#   __ok 'Spaceship prompt already exists'
# else
#   __info 'installiung spaceship prompt...'
#   git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$HOME"/.config/local/share/oh-my-zsh/custom/themes/spaceship-prompt --depth=1 && __ok ''
#   __info 'Linking spaceship prompt...'
#   ln -s "$HOME/.config/local/share/oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.config/local/share/oh-my-zsh/custom/themes/spaceship.zsh-theme" && __ok ''
# fi

# __info 'Downloading my zsh-completions...'
# if [ -e "$HOME"/.config/local/share/oh-my-zsh/custom/plugins/zsh-completions.plugin.zsh ]; then
#   __ok 'zsh-completions already exists'
# else
#   __info 'installiung zsh-completions...'
#   git clone https://github.com/danydodson/zsh-completions.git "$HOME"/.config/local/share/oh-my-zsh/custom/plugins/zsh-completions --depth=1 && __ok ''
#   __info 'Linking zsh-completions.plugin.zsh...'
#   ln -s "$HOME/.config/local/share/oh-my-zsh/custom/plugins/zsh-completions/zsh-completions.plugin.zsh" "$HOME/.config/local/share/oh-my-zsh/custom/plugins/zsh-completions.plugin.zsh" && __ok ''
# fi

# __info 'Downloading my zsh-completions submodules...'
# if [ -e "$HOME"/.config/local/share/oh-my-zsh/custom/plugins/zsh-completions ]; then
#   cd "$HOME"/.config/local/share/oh-my-zsh/custom/plugins/zsh-completions || return
#   __ok 'running git submodule init'
#   git submodule init && __ok ''
#   __ok 'running git submodule update'
#   git submodule update && __ok ''
# else
#   __info 'zsh-completions doesnt exist...'
# fi

__info 'Downloading my zsh-yarn-completions...'
if [ -e "$HOME"/.config/local/share/oh-my-zsh/custom/plugins/zsh-yarn-completions.plugin.zsh ]; then
  __ok 'zsh-completions already exists'
else
  __info 'installiung zsh-yarn-completions...'
  git clone https://github.com/chrisands/zsh-yarn-completions.git "$HOME"/.config/local/share/oh-my-zsh/custom/plugins/zsh-yarn-completions --depth=1 && __ok ''
  __info 'Linking zsh-yarn-completions.plugin.zsh...'
  ln -s "$HOME/.config/local/share/oh-my-zsh/custom/plugins/zsh-yarn-completions/zsh-yarn-completions.plugin.zsh" "$HOME/.config/local/share/oh-my-zsh/custom/plugins/zsh-yarn-completions.plugin.zsh" && __ok ''
fi

###############################################################################
# Homebrew
###############################################################################

# __info 'Adding taps to brew...'
# brew tap '1password/tap' || __err 'failed brew tap 1password/tap'
# brew tap 'homebrew/bundle' || __err 'failed brew tap homebrew/bundle'
# brew tap 'homebrew/services' || __err 'failed brew tap homebrew/services'
# brew tap 'heroku/brew' || __err 'failed brew tap heroku/brew'

# __info 'Installing binaries, terminal stuff, CLI...'
# BINARIES=(ack asciinema bat bc bun cowsay coreutils cowsay 'curl-ssl' exa fd findutils flyctl fzf gcc gh git go grep heroku htop jq make neofetch nvm openjdk perl pipenv pyenv ranger rhash ripgrep shellcheck vim wget zsh-autosuggestions zsh-completions zsh-autocomplete zsh-history-substring-search zsh-syntax-highlighting)

# # todo: check if pkg already exists
# for brew in "${BINARIES[@]}"; do
#   if ! command -v "$brew" &>/dev/null; then
#     __info "installing $brew"
#     brew install "$brew" || __err "failed brew install $brew"
#   fi
# done

# __info 'Installing casks...'
# CASKS=('1password-cli' apparency cheatsheet discord docker openinterminal postman slack spotify 'suspicious-package' 'tor-browser' transmission vlc)

# for cask in "${CASKS[@]}"; do
#   __info "installing $cask"
#   brew install --cask "$cask" || __err "failed brew cask install $cask"
# done

###############################################################################
# Clean up
###############################################################################

__info 'Cleaning up...'

brew cleanup -v && __ok ''
