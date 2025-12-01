#!/usr/bin/env bash
set -euo pipefail

###############################################################################
# GLOBAL (NSGlobalDomain / Apple Global Domain)
###############################################################################

# Disable press-and-hold for keys
defaults write -g ApplePressAndHoldEnabled -bool false

# Speed up UI animations
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSWindowResizeTime -float 0.001

# Key repeat tuning
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10

# Show all file extensions
defaults write -g AppleShowAllExtensions -bool true

# Scrollbars only when scrolling
defaults write -g AppleShowScrollBars -string "WhenScrolling"

# Always use window tabbing
defaults write -g AppleWindowTabbingMode -string "always"

# Full keyboard navigation
defaults write -g AppleKeyboardUIMode -int 2

# Disable smart substitutions/corrections
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g CheckSpellingWhileTyping -bool false

# Disable “natural” scrolling
defaults write -g com.apple.swipescrolldirection -bool false

# Disable force click
defaults write -g com.apple.trackpad.forceClick -bool false

# Speed up spring-loading (drag-hover popup)
defaults write -g com.apple.springing.delay -float 0

# Hide menu bar globally
defaults write -g _HIHideMenuBar -bool true

# Enable WebKit developer tools globally
defaults write -g WebKitDeveloperExtras -bool true

# Use blurred menu bar appearance
defaults write -g SLSMenuBarUseBlurredAppearance -bool true

# Double-click titlebar does nothing
defaults write -g AppleActionOnDoubleClick -string "None"

# Don’t tint windows by wallpaper
defaults write -g AppleReduceDesktopTinting -bool false

# Switch spaces automatically when activating apps
defaults write -g AppleSpacesSwitchOnActivate -bool true

# Accent color
defaults write -g AppleAccentColor -int 4

###############################################################################
# Accessibility
###############################################################################

# Enable system-wide accessibility
defaults write com.apple.Accessibility AccessibilityEnabled -bool true
defaults write com.apple.Accessibility ApplicationAccessibilityEnabled -bool true

# Enable Speak Selection (SpeakThis)
defaults write com.apple.Accessibility SpeakThisEnabled -bool true

# Skip SpokenContent voice dictionaries — they were environmental / dynamic.

###############################################################################
# Finder Extensions (OpenInTerminal, Keka, MEGA)
###############################################################################

defaults write -g com.apple.FinderSync.FinderSyncExtensionIDs -array \
  "com.aone.keka.KekaFinderIntegration" \
  "mega.mac.MEGAShellExtFinder" \
  "wang.jianing.app.OpenInTerminal.OpenInTerminalFinderExtension"

###############################################################################
# App-specific domains (ALL with meaningful user behavior changes)
###############################################################################

#################
# Keka
#################
# NOTE: Keka’s prefs are huge. The modified file contained many user settings.
# These lines reflect ONLY explicitly set, non-default values.

defaults write com.aone.keka DeleteAfterExtraction -bool false
defaults write com.aone.keka ExtractCommandSetOwnerAndGroup -bool false
defaults write com.aone.keka ExtractCommandSetPOSIXPermissions -bool false
defaults write com.aone.keka CompressCommandSetOwnerAndGroup -bool false
defaults write com.aone.keka CompressCommandSetPOSIXPermissions -bool false
defaults write com.aone.keka ExtractDestination -string "~/Downloads"
defaults write com.aone.keka ExtractOverwriteExisting -bool true
defaults write com.aone.keka ExtractMoveArchiveToTrash -bool false
defaults write com.aone.keka ShowHiddenFiles -bool true
defaults write com.aone.keka ShowSystemFiles -bool true
defaults write com.aone.keka SuppressFileModificationAttributes -bool false

# (If you want *all* Keka prefs reproduced exactly, say “include full Keka dump”.)

#################
# Zen Browser
#################

defaults write app.zen-browser.zen checkDefaultBrowser -bool false
defaults write app.zen-browser.zen browser.download.useDownloadDir -bool false

#################
# 1Password
#################

defaults write com.1password.1password DisableAutomaticUpdateCheck -bool true
defaults write com.1password.1password ShowDockIcon -bool false
defaults write com.1password.1password LockOnSleep -bool true
defaults write com.1password.1password LockAfterMinutesOfInactivity -int 5

#################
# OpenInTerminal
#################

defaults write wang.jianing.app.OpenInTerminal.OpenInTerminalFinderExtension \
  terminalDefault -string "iTerm"

#################
# MEGA extension prefs
#################

defaults write mega.mac.MEGAShellExtFinder ShowOverlayIcons -bool true

#################
# Crash Reporter
#################

defaults write com.Breakpad.crash_report_sender auto-send -bool false

#################
# MiniLauncher (from your system)
#################

defaults write MiniLauncher LaunchOnStartup -bool true
defaults write MiniLauncher ReduceAnimation -bool true

###############################################################################
echo "All clean, meaningful defaults applied."
