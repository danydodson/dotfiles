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
if [ -e ~/.config/local/share/oh-my-zsh/oh-my-zsh.sh ]; then
  __ok 'Oh-My-Zsh is already installed...'
else
  __info 'cloning...'
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.config/local/share/oh-my-zsh && __ok 'cloned to ~/.config/local/share/oh-my-zsh'
fi

__info 'Downloading spaceship prompt...'
if [ -e "$HOME"/.config/local/share/oh-my-zsh/custom/themes/spaceship.zsh-theme ]; then
  __ok 'Spaceship prompt already exists'
else
  __info 'installiung spaceship prompt...'
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM"/themes/spaceship-prompt --depth=1 && __ok ''
  __info 'Linking spaceship prompt...'
  ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" && __ok ''
fi

###############################################################################
# Homebrew                                                                    #
###############################################################################

__info 'Adding taps to brew...'
brew tap bramstein/webfonttools || __err 'failed brew tap bramstein/webfonttools'
brew tap heroku/brew || __err 'failed brew tap heroku/brew'
brew tap homebrew/bundle || __err 'failed brew tap homebrew/bundle'
brew tap homebrew/cask || __err 'failed brew tap homebrew/cask'
brew tap homebrew/cask-versions || __err 'failed brew tap homebrew/cask-versions'
brew tap homebrew/core || __err 'failed brew tap homebrew/core'
brew tap yt-dlp/taps || __err 'failed brew tap yt-dlp/taps'

__info 'Installing binaries, terminal stuff, CLI...'
BINARIES=(ack autoenv bat bc ca-certificates coreutils exa fd findutils fzf gh go lua mas mongocli moreutils neofetch readline pipenv pyenv ranger ripgrep shellcheck tldr tree z zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting heroku/brew/heroku yt-dlp/taps/yt-dlp)

for brew in "${BINARIES[@]}"; do
  if ! command -v "$brew" &>/dev/null; then
    __info "installing $brew"
    brew install "$brew" || __err "failed brew install $brew"
    exit
  fi
done

__info 'Installing casks...'
CASKS=(google-chrome)

for cask in "${CASKS[@]}"; do
  __info "installing $cask"
  brew install --cask "$cask" || __err "failed brew cask install $cask"
done

###############################################################################
# npm                                                                         #
###############################################################################

__info 'Installing npm packages...'
# npm install -g typescript ||  __err 'failed npm install typescript'

###############################################################################
# Mac App Store                                                               #
###############################################################################

__info 'Installing apps from App Store...'
mas install 1388020431 || __err 'failed mas install DevCleaner'
mas install 1452453066 || __err 'failed mas install Hidden Bar'
mas install 425424353 || __err 'failed mas install The Unarchiver'
mas install 497799835 || __err 'failed mas install Xcode'

__info 'Cleaning up...'

# Remove unused brew dependencies
brew cleanup -v && __ok ''
