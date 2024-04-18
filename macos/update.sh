#!/usr/bin/env bash

# Update packages

echo ' > Software update...'
sudo softwareupdate -i -a

echo ' > Upgrading oh-my-zsh...'
"$ZSH/tools/upgrade.sh"

echo ' > Upgrading global npm...'
npm update --location=global

echo ' > Upgrading homebrew...'
brew update && brew upgrade && brew autoremove && brew cleanup --prune=all -s

echo ' > Finished updating packages'