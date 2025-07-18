#!/bin/bash

# Customize dock items

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Twilight.app"
dockutil --no-restart --add "/Applications/Brave Browser.app"
dockutil --no-restart --add "/Applications/Tor Browser.app"
dockutil --no-restart --add "/Applications/Ghostty.app"
dockutil --no-restart --add "/Applications/VSCodium.app"
dockutil --no-restart --add "/Applications/Postman.app"
dockutil --no-restart --add "/Applications/Electron Fiddle.app"
dockutil --no-restart --add "/Applications/Xcode.app"
dockutil --no-restart --add "/Applications/Docker.app"
dockutil --no-restart --add "/System/Applications/Notes.app"
dockutil --no-restart --add "/Applications/Spotify.app"
dockutil --no-restart --add "/Applications/DiffusionBee.app"
dockutil --no-restart --add "/Applications/ComfyUI.app"
dockutil --no-restart --add "/Applications/GeForceNOW.app"
dockutil --no-restart --add "/Applications/Discord.app"
dockutil --no-restart --add "/Applications/IINA.app"
dockutil --no-restart --add "/Applications/mpv.app"
dockutil --no-restart --add "/Applications/VLC.app"
dockutil --no-restart --add "/Applications/LM Studio.app"
dockutil --no-restart --add "/System/Applications/Calendar.app"
dockutil --no-restart --add "/Applications/Launchpad.app"
dockutil --no-restart --add "/Applications/GPG Keychain.app"
dockutil --no-restart --add "/System/Applications/Mail.app"

killall Dock