#!/bin/bash

# Log Helpers
# . "$HOME/Developer/Dotfiles/utils/helpers.sh"
. "$HOME/Developer/Dotfiles/utils/pretty.bash"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

 __info 'Updating OSX.  If this requires a restart, run the setup.sh script again.'

 __info 'Installing all available updates...'
sudo softwareupdate -ia --verbose &&  __ok 'installed all software updates'

 __info 'Checking if xcode is installed...'
if test ! "$(xcode-select -p)"; then
  xcode-select --install &&  __ok 'installed Xcode Command Line Tools'
else
   __ok 'already installed'
fi

 __info 'Checking for homebrew...'
if test ! "$(which brew)"; then
   __info '> Installing Homebrew'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &&  __ok 'installed Homebrew'
else
   __ok 'Homebrew is already installed'
fi

 __info "Installing git config..."
 __info "What's your full name (for git purposes)?"
read -r _git_name
 __info "What's your email address?"
read -r _git_email

_DIR="$(cd "$HOME"/Developer/Dotfiles/config/git && pwd)"

for file in .gitignore .gitconfig; do
  cp -p "$_DIR"/$file "$HOME"/.config/git/$file
done

# replace the placeholders in .gitconfig with user input
sed -i -e "s/GIT_NAME/$_git_name/g" "$HOME"/.config/git/.gitconfig
sed -i -e "s/GIT_EMAIL/$_git_email/g" "$HOME"/.config/git/.gitconfig

# remove the extra file
rm -rf "$HOME"/.config/git/.gitconfig-e
