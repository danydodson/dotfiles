#!/bin/bash

# Sane OSX defaults

COMPUTER_NAME="Macbook"

# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
	sudo -n true
	sleep 60
	kill -0 "$$" || exit
done 2>/dev/null &

set -euo pipefail

###############################################################################
# Names
###############################################################################

sudo scutil --set ComputerName "$COMPUTER_NAME"
sudo scutil --set HostName "$COMPUTER_NAME"
sudo scutil --set LocalHostName "$COMPUTER_NAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$COMPUTER_NAME"

###############################################################################
# Global System
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
defaults write -g NSDisableAutomaticTermination -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false
defaults write -g NSQuitAlwaysKeepsWindows -bool false

# Scroll & Input Behavior
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

# Developer Tooling
defaults write -g WebKitDeveloperExtras -bool true

# Colors
defaults write -g AppleAccentColor -int 4
defaults write -globalDomain "AppleInterfaceStyle" -string "Dark"

defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.CrashReporter DialogType -string "none"

# Typing
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g com.apple.keyboard.fnState -bool true

# Trackpad
defaults write -g com.apple.mouse.tapBehavior -int 0
defaults write -g com.apple.mouse.tapBehavior -int 0
defaults write -g AppleEnableSwipeNavigateWithScrolls -int 0
defaults write -g com.apple.trackpad.threeFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false

# Sound Quality
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Startup Sound
sudo nvram SystemAudioVolume=" "

# Time
systemsetup -settimezone "America/Chicago" >/dev/null

# Restart
sudo systemsetup -setrestartfreeze on 2> /dev/null

# Sleep
systemsetup -setcomputersleep Off >/dev/null

# Crash Reporter
defaults write com.Breakpad.crash_report_sender auto-send -bool false
defaults write com.apple.appleseed.FeedbackAssistant Autogather -bool false

###############################################################################
# Power
###############################################################################

sudo pmset -b sleep 15
sudo pmset -b displaysleep 10
sudo pmset -b disksleep 20
sudo pmset -c sleep 15
sudo pmset -c displaysleep 10
sudo pmset -c disksleep 20
sudo pmset -c womp 0
sudo pmset -a sms 0
sudo pmset -a standbydelay 86400

###############################################################################
# MiniLauncher
###############################################################################

defaults write MiniLauncher LaunchOnStartup -bool true
defaults write MiniLauncher ReduceAnimation -bool true

###############################################################################
# Accessibility
###############################################################################

defaults write com.apple.Accessibility AccessibilityEnabled -bool true
defaults write com.apple.Accessibility ApplicationAccessibilityEnabled -bool true
defaults write com.apple.Accessibility SpeakThisEnabled -bool true

###############################################################################
# Screen
###############################################################################

defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
defaults write com.apple.screencapture location -string "$HOME/Desktop"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Dock & Hot Corners
###############################################################################

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock mouse-over-hilte-stack -bool true
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock "tilesize" -int 38
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock showhidden -bool false
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock expose-group-by-app -bool false
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Finder
###############################################################################

defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder AppleShowAllFiles -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool false
defaults write com.apple.finder ShowPathbar -boolean false
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
defaults write com.apple.finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder EmptyTrashSecurely -bool true
defaults write com.apple.finder FinderSounds -boolean false
defaults write com.apple.finder "_FXSortFoldersFirst" -bool true
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2
defaults write -g com.apple.FinderSync.FinderSyncExtensionIDs -array "com.aone.keka.KekaFinderIntegration" "mega.mac.MEGAShellExtFinder" "wang.jianing.app.OpenInTerminal.OpenInTerminalFinderExtension"

###############################################################################
# Mail
###############################################################################

defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\\U21a9"
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null

###############################################################################
# Terminal
###############################################################################

defaults write com.apple.terminal "Default Window Settings" -string "Clear Dark"
defaults write com.apple.terminal "Startup Window Settings" -string "Clear Dark"

plutil -c 'Set :"Window Settings":"Clear Dark":Bell 0' ~/Library/Preferences/com.apple.Terminal.plist
plutil -c 'Set :"Window Settings":"Clear Dark":VisualBell 0' ~/Library/Preferences/com.apple.Terminal.plist
plutil -c 'Set :"Window Settings":"Clear Dark":FontAntialias 0' ~/Library/Preferences/com.apple.Terminal.plist
plutil -c 'Set :"Window Settings":"Clear Dark":BackgroundBlur 0.5' ~/Library/Preferences/com.apple.Terminal.plist
plutil -c 'Set :"Window Settings":"Clear Dark":BackgroundBlurInactive 0.5' ~/Library/Preferences/com.apple.Terminal.plist

###############################################################################
# Bloom File Manager
###############################################################################

defaults write -g NSFileViewer -string com.asiafu.Bloom
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{LSHandlerContentType="public.folder";LSHandlerRoleAll="com.asiafu.Bloom";}'
defaults delete -g NSFileViewer
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{LSHandlerContentType="public.folder";LSHandlerRoleAll="com.apple.finder";}'

###############################################################################
# Keka
###############################################################################

defaults write com.aone.keka ExtractDestination -string "$HONE/Downloads"
defaults write com.aone.keka ExtractOverwriteExisting -bool true
defaults write com.aone.keka DeleteAfterExtraction -bool false
defaults write com.aone.keka ExtractMoveArchiveToTrash -bool false
defaults write com.aone.keka ExtractCommandSetOwnerAndGroup -bool false
defaults write com.aone.keka ExtractCommandSetPOSIXPermissions -bool false
defaults write com.aone.keka CompressCommandSetOwnerAndGroup -bool false
defaults write com.aone.keka CompressCommandSetPOSIXPermissions -bool false
defaults write com.aone.keka ShowHiddenFiles -bool true
defaults write com.aone.keka ShowSystemFiles -bool true
defaults write com.aone.keka SuppressFileModificationAttributes -bool false

###############################################################################
# Zen Browser
###############################################################################

defaults write app.zen-browser.zen checkDefaultBrowser -bool false
defaults write app.zen-browser.zen browser.download.useDownloadDir -bool false

###############################################################################
# 1Password
###############################################################################

defaults write com.1password.1password DisableAutomaticUpdateCheck -bool true
defaults write com.1password.1password ShowDockIcon -bool false
defaults write com.1password.1password LockOnSleep -bool true
defaults write com.1password.1password LockAfterMinutesOfInactivity -int 5

###############################################################################
# OpenInTerminal
###############################################################################

defaults write wang.jianing.app.OpenInTerminal.OpenInTerminalFinderExtension terminalDefault -string "Ghostty"

###############################################################################
# MEGA extension
###############################################################################

defaults write mega.mac.MEGAShellExtFinder ShowOverlayIcons -bool true

###############################################################################
# Kill affected applications
###############################################################################

for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Mail" \
	"Messages" \
	"Photos" \
	"Safari" \
	"SystemUIServer" \
	"Terminal" \
	"Transmission" \
	"Calendar"; do
	killall "${app}" &>/dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
