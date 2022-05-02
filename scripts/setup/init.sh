#!/bin/bash

# Log Helper
_info() { echo -e "\033[36m[INFO]\033[0m $1"; }
_ok() { echo -e "\033[32m[OK]\033[0m $1"; }

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

_info 'Updating OSX.  If this requires a restart, run the setup.sh script again.'

_info 'Installing all available updates...'
sudo softwareupdate -ia --verbose && _ok 'installed all software updates'

_info 'Checking if xcode is installed...'
if test ! "$(xcode-select -p)"; then
  xcode-select --install && _ok 'installed Xcode Command Line Tools'
else
  _ok 'already installed'
fi

_info 'Checking for homebrew...'
if test ! "$(which brew)"; then
  _info '> Installing Homebrew'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install --cask dropbox && _info 'installed Dropbox'
  open -a 'Dropbox' && _ok
else
  _ok 'Homebrew is already installed'
fi

_info "Installing git config..."
_info "What's your full name (for git purposes)?"
read _git_name
_info "What's your email address?"
read _git_email

_DIR="$(cd $HOME/Dotfiles/config/git && pwd)"

for file in .gitignore .gitconfig; do
  cp -p $_DIR/$file $HOME/.config/git/$file
done

# replace the placeholders in .gitconfig with user input
sed -i -e "s/GIT_NAME/$_git_name/g" $HOME/.config/git/.gitconfig
sed -i -e "s/GIT_EMAIL/$_git_email/g" $HOME/.config/git/.gitconfig

# remove the extra file
rm -rf $HOME/.config/git/.gitconfig-e
