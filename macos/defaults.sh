#!/bin/sh

# macOS defaults.

if [ "$(uname -s)" != "Darwin" ]; then
	exit 0
fi

set +e

echo ""
echo "Closing any open System Preferences panes..."
osascript -e 'tell application "System Preferences" to quit'

disable_agent() {
	mv "$1" "$1_DISABLED" >/dev/null 2>&1 ||
		sudo mv "$1" "$1_DISABLED" >/dev/null 2>&1
}

unload_agent() {
	launchctl unload -w "$1" >/dev/null 2>&1
}

sudo -v

echo ""
echo "› System:"
echo "  › Set computer name (as done via System Preferences → Sharing)"
name="0x636173616e6f7661"
sudo scutil --set ComputerName "$name" 
sudo scutil --set HostName "$name"
sudo scutil --set LocalHostName "$name"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$name"

echo "  › Disable press-and-hold for keys in favor of key repeat"
defaults write -g ApplePressAndHoldEnabled -bool false

echo "  › Use AirDrop over every interface"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

echo "  › Show the ~/Library folder"
chflags nohidden ~/Library

echo "  › Show the /Volumes folder"
sudo chflags nohidden /Volumes

echo "  › Disable startup sound"
sudo nvram SystemAudioVolume=" "

echo "  ›Change the macOS selection color to anything (this is my green)"
defaults write NSGlobalDomain AppleHighlightColor -string "0.615686 0.823529 0.454902"

echo "  › Disable resume system-wide"
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

echo "  › Set a really fast key repeat"
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

echo "  › Enable text replacement almost everywhere"
defaults write -g WebAutomaticTextReplacementEnabled -bool true

echo "  › Hide Menu Bar in Full Screen Mode"
defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -bool false

echo "  › Hide Menu Bar in Full Screen Mode"
defaults write NSGlobalDomain HideMenuBarInFullscreen -bool true

echo "  › Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "  › Only show scrollbars when scrolling"
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

echo "  › Disable Dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true

echo "  › Don't automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

echo "  › Increase the window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "  › Disable automatic capitalization"
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

echo "  › Disable smart quotes and smart dashes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "  › Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "  › Avoid the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "  › Disable the 'Are you sure you want to open this application?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "  › Speed up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400

echo "  › Disabling the Launchpad gesture (pinch with thumb and three fingers)"
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0

echo "  › Disable 'natural' scrolling"
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

echo "  › Sleep the display after 15 minutes"
sudo pmset -a displaysleep 15

echo "  › Removing duplicates in the 'Open With' menu"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
	-kill -r -domain local -domain system -domain user

#############################

echo ""
echo "› Finder:"
echo "  › Always open everything in Finder's col view"
defaults write com.apple.finder FXPreferredViewStyle -string 'clmv'

echo "  › Set the Finder prefs for showing a few different volumes on the Desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

echo "  › Set Home as the default location for new Finder windows"
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

echo "  › Show hidden files by default"
defaults write com.apple.finder AppleShowAllFiles -bool true

echo "  › Show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "  › Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

echo "  › Set sidebar icon size to medium"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

echo "  › Show status bar"
defaults write com.apple.finder ShowStatusBar -bool false

echo "  › Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "  › Disable desktop animations to work with skhd"
defaults write com.apple.finder DisableAllAnimations -bool true

echo "  › Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "  › Save to disk by default, instead of iCloud"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "  › Hide full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool false

echo "  › Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "  › Keep folders on top when sorting by name"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

echo "  › When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "  › Enable spring loading for directories"
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

echo "  › Remove the spring loading delay for directories"
defaults write NSGlobalDomain com.apple.springing.delay -float 0

#############################

echo ""
echo "› Trackpad:"
echo "  › Disable trackpad force click"
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool false

echo "  › Enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

#############################

echo ""
echo "› Photos:"
echo "  › Disable it from starting everytime a device is plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

#############################

echo ""
echo "› Browsers:"
echo "  › Hide Safari's bookmark bar"
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo "  › Set up Safari for development"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo "  › Disable the annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false

#############################

echo ""
echo "› Dock"
echo "  › Setting the icon size of Dock items to 45 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 45

echo "  › Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool false

echo "  › Remove the auto-hiding Dock delay"
defaults write com.apple.dock autohide-delay -float 0

echo "  › Remove the animation when hiding/showing the Dock"
defaults write com.apple.dock autohide-time-modifier -float 0.3

echo "  › Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo "  › Don't animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false

echo "  > Don’t show recent applications in Dock"
defaults write com.apple.dock show-recents -bool false

echo "  > Minimize windows into their application’s icon"
defaults write com.apple.dock minimize-to-application -bool true

echo "  > Top right screen hot corner mission control"
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0

echo "  > Bottom left screen hot corner launchpad"
defaults write com.apple.dock wvous-bl-corner -int 11
defaults write com.apple.dock wvous-bl-modifier -int 0

#############################

echo ""
echo "› Mail:"
echo "  › Add the keyboard shortcut CMD + Enter to send an email"
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"
echo "  › Add the keyboard shortcut CMD + Shift + E to archive an email"
# shellcheck disable=SC2016
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Archive" '@$e'

echo "  › Disable smart quotes as it's annoying for messages that contain code"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

echo "  › Set email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>'"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "  › Display emails in threaded mode, sorted by date (oldest at the top)"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

echo "  › Disable inline attachments (just show the icons)"
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

echo "  › Disable automatic spell checking"
defaults write com.apple.mail SpellCheckingBehavior -string "NoSpellCheckingEnabled"

echo "  ›  Disable send and reply animations in Mail.app"
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

#############################

echo ""
echo "› Time Machine:"
echo "  › Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
# SSD-specific tweaks                                                         #
###############################################################################
if diskutil info disk0 | grep SSD >/dev/null 2>&1; then
	echo "  › Disable local backups"
	# https://classicyuppie.com/what-crap-is-this-os-xs-mobilebackups/
	sudo tmutil disablelocal

	echo "  › Disable hibernation (speeds up entering sleep mode)"
	sudo pmset -a hibernatemode 0

	echo "  › Remove the sleep image file to save disk space"
	sudo rm /private/var/vm/sleepimage
	echo "  › Create a zero-byte file instead..."
	sudo touch /private/var/vm/sleepimage
	echo "  › ...and make sure it can’t be rewritten"
	sudo chflags uchg /private/var/vm/sleepimage

	echo "  ›  Disable the sudden motion sensor as it’s not useful for SSDs"
	sudo pmset -a sms 0
fi

#############################

echo ""
echo "› Media:"

echo "  › Disable iTunes helper"
disable_agent /Applications/iTunes.app/Contents/MacOS/iTunesHelper.app
echo "  › Prevent play button from launching iTunes"
unload_agent /System/Library/LaunchAgents/com.apple.rcd.plist

echo "  › Disable Spotify web helper"
disable_agent ~/Applications/Spotify.app/Contents/MacOS/SpotifyWebHelper

#############################

echo ""
echo "› Kill related apps"
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
	"Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
	"Terminal" "Photos"; do
	killall "$app" >/dev/null 2>&1
done
set -e
