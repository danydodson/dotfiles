#!/bin/bash

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Oh-My-Zsh                                                                   #
###############################################################################
__info 'Installing oh-my-zsh...'

if test ! "$(which omz)"; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.config/local/share/oh-my-zsh && __ok ''
fi

__info 'Downloading zsh-tab-title plugin...'
git clone https://github.com/trystan2k/zsh-tab-title \
  "$ZSH_CUSTOM"/plugins/zsh-tab-title && __ok ''

__info 'Downloading zsh-wakatime plugin...'
git clone https://github.com/wbingli/zsh-wakatime.git \
  "$ZSH_CUSTOM"/plugins/zsh-wakatime && __ok ''

__info 'Downloading spaceship prompt...'
git clone https://github.com/spaceship-prompt/spaceship-prompt.git \
  "$ZSH_CUSTOM"/themes/spaceship-prompt --depth=1 && __ok ''

__info 'Linking spaceship prompt...'
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" && __ok ''

###############################################################################
# Homebrew                                                                    #
###############################################################################
__info 'Adding taps to brew...'

brew tap homebrew/bundle ||  __err 'failed brew taphomebrew/bundle'
brew tap homebrew/cask-versions ||  __err 'failed brew tap homebrew/cask-versions'
brew tap heroku/brew ||  __err 'failed brew tap heroku/brew'

__info 'Installing binaries, terminal stuff, CLI...'

BINARIES=(
  ack
  bat
  bc
  ca-certificates
  coreutils
  exa
  fd
  findutils
  fzf
  gh
  heroku/brew/heroku
  mas
  mongocli
  moreutils
  neofetch
  readline
  shellcheck
  tldr
  z
  zsh-autosuggestions
  zsh-completions
  zsh-history-substring-search
  zsh-syntax-highlighting
)

for brew in "${BINARIES[@]}"; do
  __info "installing $brew"
  brew install "$brew" ||  __err "failed brew install $brew"
done

__info 'Installing dev environment...'

DEV_LIBRARIES=(
  lua
)

for brew in "${DEV_LIBRARIES[@]}"; do
  __info "installing $brew"
  brew install "$brew" ||  __err "failed brew install $brew"
done

__info 'Installing misc casks...'
MISC_CASKS=(
  google-chrome
)

for cask in "${MISC_CASKS[@]}"; do
  __info "installing $cask"
  brew install --cask "$cask" ||  __err "failed brew cask install $cask"
done

###############################################################################
# npm                                                                         #
###############################################################################
# __info 'Installing npm packages...'
# npm install -g typescript ||  __err 'failed npm install typescript'

###############################################################################
# Mac App Store                                                               #
###############################################################################
# __info 'Installing apps from App Store...'
# mas install 497799835 ||  __err 'failed mas install Xcode'

__info 'Cleaning up...'

# Remove unused brew dependencies
brew cleanup -v && __ok ''
