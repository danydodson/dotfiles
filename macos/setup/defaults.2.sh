#!/usr/bin/env bash
set -euo pipefail

###############################################################################
# GLOBAL SYSTEM PREFERENCES (NSGlobalDomain)
###############################################################################

# Interaction / Keyboard
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10
defaults write -g AppleKeyboardUIMode -int 2

# UI / Animation / Behavior
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSWindowResizeTime -float 0.001
defaults write -g AppleShowAllExtensions -bool true
defaults write -g AppleWindowTabbingMode -string "always"
defaults write -g AppleShowScrollBars -string "WhenScrolling"
defaults write -g AppleReduceDesktopTinting -bool false
defaults write -g AppleActionOnDoubleClick -string "None"
defaults write -g SLSMenuBarUseBlurredAppearance -bool true
defaults write -g _HIHideMenuBar -bool true
defaults write -g AppleMenuBarVisibleInFullscreen -bool false

# Scroll & input behavior
defaults write -g com.apple.swipescrolldirection -bool false
defaults write -g com.apple.trackpad.forceClick -bool false
defaults write -g com.apple.springing.delay -float 0
defaults write -g AppleSpacesSwitchOnActivate -bool true

# Smart substitutions and correction
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g CheckSpellingWhileTyping -bool false

# Developer tooling
defaults write -g WebKitDeveloperExtras -bool true

# Accent color
defaults write -g AppleAccentColor -int 4

###############################################################################
# FINDER SYNC EXTENSIONS
###############################################################################

defaults write -g com.apple.FinderSync.FinderSyncExtensionIDs -array \
  "com.aone.keka.KekaFinderIntegration" \
  "mega.mac.MEGAShellExtFinder" \
  "wang.jianing.app.OpenInTerminal.OpenInTerminalFinderExtension"

###############################################################################
# ACCESSIBILITY
###############################################################################

defaults write com.apple.Accessibility AccessibilityEnabled -bool true
defaults write com.apple.Accessibility ApplicationAccessibilityEnabled -bool true
defaults write com.apple.Accessibility SpeakThisEnabled -bool true

###############################################################################
# APP: Keka — meaningful preferences
###############################################################################

# Extraction behavior
defaults write com.aone.keka ExtractDestination -string "~/Downloads"
defaults write com.aone.keka ExtractOverwriteExisting -bool true
defaults write com.aone.keka DeleteAfterExtraction -bool false
defaults write com.aone.keka ExtractMoveArchiveToTrash -bool false

# Permissions / ownership copying
defaults write com.aone.keka ExtractCommandSetOwnerAndGroup -bool false
defaults write com.aone.keka ExtractCommandSetPOSIXPermissions -bool false
defaults write com.aone.keka CompressCommandSetOwnerAndGroup -bool false
defaults write com.aone.keka CompressCommandSetPOSIXPermissions -bool false

# Visibility
defaults write com.aone.keka ShowHiddenFiles -bool true
defaults write com.aone.keka ShowSystemFiles -bool true

# Common behavior/prefs
defaults write com.aone.keka SuppressFileModificationAttributes -bool false

###############################################################################
# APP: Zen Browser
###############################################################################

defaults write app.zen-browser.zen checkDefaultBrowser -bool false
defaults write app.zen-browser.zen browser.download.useDownloadDir -bool false

###############################################################################
# APP: 1Password
###############################################################################

defaults write com.1password.1password LockOnSleep -bool true
defaults write com.1password.1password LockAfterMinutesOfInactivity -int 5
defaults write com.1password.1password ShowDockIcon -bool false
defaults write com.1password.1password DisableAutomaticUpdateCheck -bool true

###############################################################################
# APP: OpenInTerminal
###############################################################################

defaults write wang.jianing.app.OpenInTerminal.OpenInTerminalFinderExtension \
  terminalDefault -string "iTerm"

###############################################################################
# APP: MEGA Finder Extension
###############################################################################

defaults write mega.mac.MEGAShellExtFinder ShowOverlayIcons -bool true

###############################################################################
# APP: MiniLauncher
###############################################################################

defaults write MiniLauncher LaunchOnStartup -bool true
defaults write MiniLauncher ReduceAnimation -bool true

###############################################################################
# APP: Crash Reporter (Breakpad)
###############################################################################

defaults write com.Breakpad.crash_report_sender auto-send -bool false

###############################################################################
# APP: Adobe XML / JNode
# (Only meaningful prefs; no internal cache/state)
###############################################################################

# These prefs were lightweight. Only keep functional keys.
defaults write com.adobe.xml.jnode AllowNetworkAccess -bool true

###############################################################################
echo "All human-usable defaults applied successfully."