#!/bin/bash

# updates and checks homebrew status

# Log Helper
_info() { echo -e "\033[36m[INFO]\033[0m $1"; }

_info "> Homebrew update"
brew update

_info "> Homebrew upgrade"
brew upgrade

_info "> Homebrew cleanup and prune"
brew cleanup --prune=all -s

_info "> Homebrew doctor"
brew doctor
