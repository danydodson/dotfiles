#!/usr/bin/env bash

#######################################################################
# path
#######################################################################

path-prepend "$HOME/.config/iterm2/utils"
path-prepend "/opt/homebrew/opt/mysql-client/bin"
path-prepend "/opt/homebrew/opt/openjdk/bin"
path-prepend "/opt/homebrew/opt/coreutils/libexec/gnubin"
path-prepend "/opt/homebrew/opt/findutils/libexec/gnubin"
path-prepend "/opt/homebrew/opt/grep/libexec/gnubin"
path-prepend "/opt/homebrew/opt/php@8.1/bin"
path-prepend "/opt/homebrew/opt/php@8.1/sbin"
path-prepend "/opt/homebrew/opt/ruby@2.7/bin"
path-prepend "/opt/homebrew/opt/openssl@3/bin"
path-prepend "/opt/homebrew/opt/openssl@1.1/bin"
path-prepend "/opt/homebrew/opt/curl/bin"
path-prepend "/opt/homebrew/opt/bc/bin"
path-prepend "/opt/homebrew/opt/fzf/bin"
path-prepend "/opt/homebrew/sbin"
path-prepend "/opt/homebrew/bin"
path-prepend "$DOTFILES/bin"

path-prepend "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

#######################################################################
# fpath
#######################################################################

fpath-prepend "/opt/homebrew/share/zsh/site-functions"
fpath-prepend "/opt/homebrew/share/zsh/zsh-completions"
