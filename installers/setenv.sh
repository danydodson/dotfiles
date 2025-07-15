#!/usr/bin/env bash

cp $HOME/.dotfiles/installers/setenv.moz.plist "$HOME/Library/LaunchAgents/"
launchctl load -w "$HOME/Library/LaunchAgents/setenv.moz.plist"

rm "$HOME/Library/LaunchAgents/setenv.moz.plist"
launchctl unsetenv.moz.plist
