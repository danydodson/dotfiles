#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/VSCodium.app"
dockutil --no-restart --add "/Applications/Zen.app"
dockutil --no-restart --add "/Applications/Brave Browser.app"
dockutil --no-restart --add "/Applications/Xcode.app"
dockutil --no-restart --add "/Applications/Postman.app"
dockutil --no-restart --add "/Applications/Ghostty.app"
dockutil --no-restart --add "/System/Applications/Notes.app"
dockutil --no-restart --add "/Applications/Discord.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/NVIDIA GeForce NOW.app"
dockutil --no-restart --add "/Applications/DiffusionBee.app"
dockutil --no-restart --add "/Applications/ChatGPT.app"
dockutil --no-restart --add "/Applications/VLC.app"
dockutil --no-restart --add "/Applications/MEGAVPN.app"
dockutil --no-restart --add "/Applications/Transmission.app"
dockutil --no-restart --add "/System/Applications/Mail.app"
dockutil --no-restart --add "/System/Applications/Calendar.app"

killall Dock
