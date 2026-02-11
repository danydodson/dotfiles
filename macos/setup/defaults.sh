#!/bin/bash

# Sane OSX defaults

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
# General UI/UX                                                               #
###############################################################################

# Menu bar: hide menu bar
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# Menu bar: hide the useless Time Machine and Volume icons
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/VPN.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu"

# Show scrollbars only when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Resume system-wide
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Restart automatically if the computer freezes
systemsetup -setrestartfreeze on

# Never go into computer sleep mode
systemsetup -setcomputersleep Off >/dev/null

# Set to dark mode
defaults write -globalDomain "AppleInterfaceStyle" -string "Dark"

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool false
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool false
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 0

# Trackpad: swipe between pages with three fingers
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Don't illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool false

# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

# Set the timezone; see `systemsetup -listtimezones` for other values
systemsetup -settimezone "America/Chicago" >/dev/null

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Keyboard: Set function keys to behave as standard function keys.
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

###############################################################################
# Screen                                                                      #
###############################################################################

defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
defaults write com.apple.screencapture location -string "$HOME/Desktop"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Finder                                                                      #
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

###############################################################################
# Dock & hot corners                                                          #
###############################################################################

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilte-stack -bool true

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Set the icon size of Dock items to 48 pixels
defaults write com.apple.dock "tilesize" -int 38

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool false

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Disable the Launchpad gesture (pinch with thumb and three fingers)
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

# Mission Control: Speed up animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Mission Control: Dont group windows by application
defaults write com.apple.dock expose-group-by-app -bool false

# Mission Control: Dont rearrange Spaces automatically
defaults write com.apple.dock mru-spaces -bool false

# Add iOS Simulator to Launchpad
# ln -s /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app /Applications/iOS\ Simulator.app
# sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/Simulator (Watch).app" "/Applications/Simulator (Watch).app"

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# Top left screen corner → disabled
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right screen corner → Launchpad
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left screen corner → Mission Control
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom right screen corner → disabled
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Misc                                                                        #
###############################################################################

# Disable spell check as you type
defaults write -g CheckSpellingWhileTyping -boolean false

# Disable startup sound
sudo nvram SystemAudioVolume=" "

# Disable autogather large files when submitting a feedback report
defaults write com.apple.appleseed.FeedbackAssistant Autogather -bool false

# Dont keep windows when quitting an application
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindow -bool false

# Music: Dont Display a notification when a new song starts in the Music app
defaults write com.apple.Music userWantsPlaybackNotifications -bool false

###############################################################################
# Bloom File Manager                                                          #
###############################################################################

defaults write -g NSFileViewer -string com.asiafu.Bloom
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{LSHandlerContentType="public.folder";LSHandlerRoleAll="com.asiafu.Bloom";}'
defaults delete -g NSFileViewer
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add '{LSHandlerContentType="public.folder";LSHandlerRoleAll="com.apple.finder";}'

###############################################################################
# GLOBAL SYSTEM PREFERENCES
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
# MEGA Finder Extension
###############################################################################

defaults write mega.mac.MEGAShellExtFinder ShowOverlayIcons -bool true

###############################################################################
# MiniLauncher
###############################################################################

defaults write MiniLauncher LaunchOnStartup -bool true
defaults write MiniLauncher ReduceAnimation -bool true

###############################################################################
# Crash Reporter
###############################################################################

defaults write com.Breakpad.crash_report_sender auto-send -bool false

###############################################################################
# Adobe XML / JNode
###############################################################################

defaults write com.adobe.xml.jnode AllowNetworkAccess -bool true

###############################################################################
# Mail                                                                        #
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
	terminalDefault -string "Ghostty"

#################
# MEGA extension
#################

defaults write mega.mac.MEGAShellExtFinder ShowOverlayIcons -bool true

#################
# Crash Reporter
#################

defaults write com.Breakpad.crash_report_sender auto-send -bool false

#################
# MiniLauncher
#################

defaults write MiniLauncher LaunchOnStartup -bool true
defaults write MiniLauncher ReduceAnimation -bool true

###############################################################################
# Power                                                                       #
###############################################################################

sudo pmset -b sleep 15
sudo pmset -b displaysleep 10
sudo pmset -b disksleep 20
sudo pmset -c sleep 15
sudo pmset -c displaysleep 10
sudo pmset -c disksleep 20
sudo pmset -c womp 0

###############################################################################
# Kill affected applications                                                  #
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
