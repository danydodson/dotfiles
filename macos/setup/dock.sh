#!/bin/bash

# Customize dock items

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Bloom.app"
dockutil --no-restart --add "/Applications/Twilight.app"
dockutil --no-restart --add "/Applications/Brave Browser.app"
dockutil --no-restart --add "/Applications/Safari.app"
dockutil --no-restart --add "/Applications/VSCodium.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Xcode.app"
dockutil --no-restart --add "/Applications/Port Killer.app"
dockutil --no-restart --add "/Applications/Ghostty.app"
dockutil --no-restart --add "/Applications/Taphouse.app"
dockutil --no-restart --add "/Applications/Codex.app"
dockutil --no-restart --add "/Applications/ChatGPT.app"
dockutil --no-restart --add "/Applications/Shortcuts.app"
dockutil --no-restart --add "/System/Library/CoreServices/Applications/Keychain Access.app"
dockutil --no-restart --add "/Applications/File Juicer.app"
dockutil --no-restart --add "/Applications/IINA.app"
dockutil --no-restart --add "/System/Applications/Notes.app"
dockutil --no-restart --add "/System/Applications/Mail.app"
dockutil --no-restart --add "/System/Applications/Calendar.app"

killall Dock