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
# ZSH                                                                         #
###############################################################################
_info 'Installing zsh...'

brew install zsh || _error 'failed installing zsh'

# _info 'Installing the Dracula theme for iTerm (opening file)'
# open '~Developer/Dotfiles/config/iterm/Dracula.itermcolors' && _ok ''

_info 'Setting ZSH as the default shell environment'
sudo sh -c 'echo $(which zsh) >> /etc/shells'
chsh -s "$(which zsh)" && _ok ''

###############################################################################
# Oh-My-Zsh                                                                   #
###############################################################################
_info 'Installing oh-my-zsh...'

if test ! "$(which omz)"; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.config/local/share/oh-my-zsh && _ok ''
fi

_info 'Downloading zsh-autosuggestions plugin...'
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.config/local/oh-my-zsh/custom}/plugins/zsh-autosuggestions && _ok ''

_info 'Downloading zsh-syntax-highlighting plugin...'
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.config/local/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && _ok ''

_info 'Downloading alias-tips plugin...'
git clone https://github.com/djui/alias-tips.git \
  ${ZSH_CUSTOM:-~/.config/local/oh-my-zsh/custom}/plugins/alias-tips && _ok ''

_info 'Downloading zsh-tab-title plugin...'
git clone https://github.com/trystan2k/zsh-tab-title \
  ${ZSH_CUSTOM:-~/.config/local/oh-my-zsh/custom}/plugins/zsh-tab-title && _ok ''

_info 'Downloading zsh-wakatime plugin...'
git clone https://github.com/wbingli/zsh-wakatime.git \
  ${ZSH_CUSTOM:-~/.config/local/oh-my-zsh/custom}/plugins/zsh-wakatime && _ok ''

_info 'Downloading fast-syntax-highlighting plugin...'
git clone https://github.com/z-shell/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-~/.config/local/oh-my-zsh/custom}/plugins/fast-syntax-highlighting && _ok ''

_info 'Downloading history-search-multi-word plugin...'
git clone git@github.com:zdharma-continuum/history-search-multi-word.git \
  ${ZSH_CUSTOM:-~/.config/local/oh-my-zsh/custom}/plugins/history-search-multi-word && _ok ''

###############################################################################
# Homebrew                                                                    #
###############################################################################
_info 'Adding taps to brew...'

brew tap homebrew/bundle || _error 'failed brew taphomebrew/bundle'
brew tap homebrew/cask-versions || _error 'failed brew tap homebrew/cask-versions'
brew tap heroku/brew || _error 'failed brew tap heroku/brew'
brew tap bramstein/webfonttools || _error 'failed brew tap bramstein/webfonttools'

_info 'Installing binaries, terminal stuff, CLI...'
BINARIES=(ack aircrack-ng asdf autoenv awscli bash bat bc coreutils exa fd findutils folderify fzf gawk gcc gh go gpg grep heroku htop httpie irssi jq macvim mas mongocli moreutils readline ranger sfnt2woff sfnt2woff-zopfli woff2 shellcheck spark tag thefuck tldr trash tree wget yarn yt-dlp z zsh-history-substring-search zsh-autosuggestions zsh-syntax-highlighting)
for brew in "${BINARIES[@]}"; do
  _info "installing $brew"
  brew install "$brew" || _error "failed brew install $brew"
done

_info 'Installing dev environment...'
DEV_LIBRARIES=(lua node)
for brew in "${DEV_LIBRARIES[@]}"; do
  _info "installing $brew"
  brew install "$brew" || _error "failed brew install $brew"
done

_info 'Installing dev tool casks...'
DEV_CASKS=(chromedriver mongodb-compass postman insomnia iterm2 robo-3t visual-studio-code)
for cask in "${DEV_CASKS[@]}"; do
  _info "installing $cask"
  brew install --cask "$cask" || _error "failed brew cask install $cask"
done

_info 'Installing misc casks...'
MISC_CASKS=(apparency appcleaner asset-catalog-tinkerer battle-net bitwarden blackhole-2ch blackhole-16ch discord dropbox firefox-developer-edition google-chrome netnewswire nvidia-geforce-now slack spotify steam streamlabs-obs suspicious-package the-unarchiver tor-browser transmission vlc whatsapp xbar)
for cask in "${MISC_CASKS[@]}"; do
  _info "installing $cask"
  brew install --cask "$cask" || _error "failed brew cask install $cask"
done

###############################################################################
# npm                                                                         #
###############################################################################
# _info 'Installing npm packages...'
npm install -g typescript || _error 'failed npm install typescript'

###############################################################################
# Mac App Store                                                               #
###############################################################################
# _info 'Installing apps from App Store...'
# mas install 497799835 || _error 'failed mas install Xcode'

_info 'Cleaning up...'

# Remove unused brew dependencies
brew cleanup -v && _ok ''
