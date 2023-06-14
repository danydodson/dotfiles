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
  git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$HOME"/.config/local/share/oh-my-zsh/custom/themes/spaceship-prompt --depth=1 && __ok ''
  __info 'Linking spaceship prompt...'
  ln -s "$HOME/.config/local/share/oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.config/local/share/oh-my-zsh/custom/themes/spaceship.zsh-theme" && __ok ''
fi

###############################################################################
# Homebrew
###############################################################################

__info 'Adding taps to brew...'
brew tap '1password/tap' || __err 'failed brew tap 1password/tap'
brew tap 'apple/apple' || __err 'failed brew tap apple/apple'
brew tap 'homebrew/bundle' || __err 'failed brew tap homebrew/bundle'
brew tap 'homebrew/cask' || __err 'failed brew tap homebrew/cask'
brew tap 'homebrew/cask-versions' || __err 'failed brew tap homebrew/cask-versions'
brew tap 'homebrew/core' || __err 'failed brew tap homebrew/core'
brew tap 'homebrew/services' || __err 'failed brew tap homebrew/services'
brew tap 'yt-dlp/taps' || __err 'failed brew tap yt-dlp/taps'

__info 'Installing binaries, terminal stuff, CLI...'
BINARIES=(ack bat bc code-cli coreutils exa fd findutils flyctl fzf gh go httpd hydra mas mongocli mongodb-atlas-cli moreutils neofetch nvm openjdk pipenv pyenv ranger rhash ripgrep shellcheck tree vim wget yarn yt-dlp z zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting)

# todo: check if pkg already exists
for brew in "${BINARIES[@]}"; do
  if ! command -v "$brew" &>/dev/null; then
    __info "installing $brew"
    brew install "$brew" || __err "failed brew install $brew"
  fi
done

__info 'Installing casks...'
CASKS=('1password-cli' apparency cheatsheet dropbox hammerspoon onyx open-in-code spotify suspicious-package tor-browser transmission vlc)

for cask in "${CASKS[@]}"; do
  __info "installing $cask"
  brew install --cask "$cask" || __err "failed brew cask install $cask"
done

###############################################################################
# nvm
###############################################################################

source ~/.config/nvm/nvm.sh

__info 'Installing node --lts...'
nvm install 'lts/*' --reinstall-packages-from=default --latest-npm || __err 'failed to install node --lts'
nvm use --lts

###############################################################################
# npm
###############################################################################

__info 'Installing npm global packages...'
npm install -g typescript || __err 'failed npm install -g typescript'

###############################################################################
# yarn
###############################################################################

__info 'Installing yarn global packages...'
yarn global add gatsby-cli || __err 'failed yarn global add gatsby-cli'

###############################################################################
# lua
###############################################################################

__info 'Installing luarocks packages...'
luarocks install checks || __err 'failed luarocks install checks'
luarocks --lua-dir=/opt/homebrew/opt/lua@5.1 install metalua-compiler || __err 'failed luarocks install metalua-compiler'
luarocks --lua-dir=/opt/homebrew/opt/lua@5.1 install formatter || __err 'failed luarocks install formatter'
luarocks install lanes || __err 'failed luarocks install lanes'
luarocks --lua-dir=/opt/homebrew/opt/lua@5.3 install lua-lsp || __err 'failed luarocks install lua-lsp'
luarocks install luacheck || __err 'failed luarocks install luacheck'
luarocks install --server=https://luarocks.org/dev argcheck || __err 'failed luarocks install argcheck'
luarocks install busted || __err 'failed luarocks install busted'
luarocks install luacov || __err 'failed luarocks install luacov'

###############################################################################
# pyenv
###############################################################################

# source /opt/homebrew/bin/pyenv

# __install() {
#   # Make sure not using system python and pip
#   if python -m pip --version | grep -q /usr/lib; then
#     __err "System pip detected, not running. Use a userspace python's pip."
#     exit 1
#   fi

#   # Make sure has pyenv
#   if ! __has "pyenv"; then
#     __err "pyenv is not installed. Install it and set up a global pyenv."
#     exit 1
#   fi

#   if pyenv version | grep -q system; then
#     __err "Using system pyenv. Use real pyenv instead."
#     exit 1
#   fi

#   __status "Updating global pip"
#   python -m pip install --upgrade pip

#   __status "Updating global pip requirements"
#   python -m pip install --upgrade --requirement "${DOTFILES}/config/python/requirements.txt"
# }

# __install "$@"

###############################################################################
# Clean up
###############################################################################

__info 'Cleaning up...'

brew cleanup -v && __ok ''
