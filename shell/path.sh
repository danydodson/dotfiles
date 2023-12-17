#!/usr/bin/env bash

#######################################################################
# path
#######################################################################

path-prepend "$DOTFILES/bin"
path-prepend "$HOME/.config/iterm2"
path-prepend "$HOME/.config/go/bin"
path-prepend "$HOME/.config/dotnet"
path-prepend "/Applications/MEGAcmd.app/Contents/MacOS"
path-prepend "/opt/homebrew/opt/go/libexec/bin"
path-prepend "/opt/homebrew/opt/openjdk/bin"
path-prepend "/opt/homebrew/opt/coreutils/libexec/gnubin"
path-prepend "/opt/homebrew/opt/findutils/libexec/gnubin"
path-prepend "/opt/homebrew/opt/grep/libexec/gnubin"
path-prepend "/opt/homebrew/opt/openjdk@17/bin"
path-prepend "/opt/homebrew/opt/curl/bin"
path-prepend "/opt/homebrew/opt/bc/bin"
path-prepend "/opt/homebrew/opt/fzf/bin"
path-prepend "/opt/homebrew/sbin"
path-prepend "/opt/homebrew/bin"

#######################################################################
# fpath
#######################################################################

fpath-prepend "/opt/homebrew/share/zsh/site-functions"
fpath-prepend "/opt/homebrew/share/zsh/zsh-completions"

#######################################################################
# vscode
#######################################################################

path-prepend "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
