#!/bin/bash

# Log Helper
_info() { echo -e "\033[36m[INFO]\033[0m $1"; }
_ok() { echo -e "\033[32m[OK]\033[0m $1"; }
_error() { echo -e "\033[31m[ERROR]\033[0m $1"; }

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Oh-My-Zsh                                                                   #
###############################################################################
_info 'Installing oh-my-zsh...'

if test ! "$(which omz)"; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.config/local/share/oh-my-zsh && _ok ''
fi

_info 'Downloading zsh-tab-title plugin...'
git clone https://github.com/trystan2k/zsh-tab-title \
  "$ZSH_CUSTOM"/plugins/zsh-tab-title && _ok ''

_info 'Downloading zsh-wakatime plugin...'
git clone https://github.com/wbingli/zsh-wakatime.git \
  "$ZSH_CUSTOM"/plugins/zsh-wakatime && _ok ''

_info 'Downloading spaceship prompt...'
git clone https://github.com/spaceship-prompt/spaceship-prompt.git \
  "$ZSH_CUSTOM"/themes/spaceship-prompt --depth=1 && _ok ''

_info 'Linking spaceship prompt...'
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" && _ok ''

###############################################################################
# Homebrew                                                                    #
###############################################################################
_info 'Adding taps to brew...'

brew tap homebrew/bundle || _error 'failed brew taphomebrew/bundle'
brew tap homebrew/cask-versions || _error 'failed brew tap homebrew/cask-versions'
brew tap heroku/brew || _error 'failed brew tap heroku/brew'

_info 'Installing binaries, terminal stuff, CLI...'

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
  _info "installing $brew"
  brew install "$brew" || _error "failed brew install $brew"
done

_info 'Installing dev environment...'

DEV_LIBRARIES=(
  lua
)

for brew in "${DEV_LIBRARIES[@]}"; do
  _info "installing $brew"
  brew install "$brew" || _error "failed brew install $brew"
done

_info 'Installing misc casks...'
MISC_CASKS=(
  google-chrome
)

for cask in "${MISC_CASKS[@]}"; do
  _info "installing $cask"
  brew install --cask "$cask" || _error "failed brew cask install $cask"
done

###############################################################################
# npm                                                                         #
###############################################################################
# _info 'Installing npm packages...'
# npm install -g typescript || _error 'failed npm install typescript'

###############################################################################
# Mac App Store                                                               #
###############################################################################
# _info 'Installing apps from App Store...'
# mas install 497799835 || _error 'failed mas install Xcode'

_info 'Cleaning up...'

# Remove unused brew dependencies
brew cleanup -v && _ok ''
