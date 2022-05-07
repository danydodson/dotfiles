#!/bin/bash

# Log Helper
_info() { echo -e "\033[36m[INFO]\033[0m $1"; }
_ok() { echo -e "\033[32m[OK]\033[0m $1"; }
_error() { echo -e "\033[31m[ERROR]\033[0m $1"; }

###############################################################################
# Prompt user input                                                           #
###############################################################################

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

_info 'These first changes request your input... \n'

read -r -p 'Do you want to change your computer and host name? [y|N] ' response
if [[ $response =~ (yes|y|Y) ]]; then
	read -r -p "Computer: change $(sudo scutil --get ComputerName) to: " _computer_name
	sudo scutil --set ComputerName "$_computer_name" && _ok 'changed computer name'
	read -r -p "Localhost: change $(sudo scutil --get LocalHostName) to: " _local_host_name
	sudo scutil --set LocalHostName "$_local_host_name" && _ok 'changed host name'
else
	_ok 'skipped'
fi

read -r -p 'Do you want to overwrite /etc/hosts with the ad-blocking hosts file from someonewhocares.org [y|N] ' response
if [[ $response =~ (yes|y|Y) ]]; then
	_info 'Backing up current /etc/hosts to /etc/hosts.backup'
	sudo cp /etc/hosts /etc/hosts.backup && _ok 'backed up hosts'
	_info 'Overwriting /etc/hosts'
	sudo cp ./settings/system/hosts /etc/hosts && _ok 'overwrote hosts'
else
	_ok 'skipped'
fi

_info 'Closing any open System Preferences panes...'
osascript -e 'tell application 'System Preferences' to quit'

###############################################################################
# Activity Monitor                                                            #
###############################################################################
_info 'Changing Activity Monitor settings...'

# visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string 'CPUUsage'
defaults write com.apple.ActivityMonitor SortDirection -int 0

####################################################################################
# Address Book                                                                     #
####################################################################################
_info 'Changing Address Book settings...'

# enable the debug menu in Address Book
defaults write com.apple.addressbook ABShowDebugMenu -bool true

#######################################################################################
# Bluetooth Accessories                                                               #
#######################################################################################
_info 'Changing Bluetooth settings...'

# enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent 'Apple Bitpool Min (editable)' -int 40

####################################################################################
# Disk Utility                                                                     #
####################################################################################
_info 'Changing Disc Utility settings...'

# enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# Dock                                                                        #
###############################################################################
_info 'Changing Dock settings...'

# minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# show indicator lights for open applications in the dock
defaults write com.apple.dock show-process-indicators -bool true

# automatically hide and show the dock
defaults write com.apple.dock autohide -bool true

# don’t animate opening applications from the dock
defaults write com.apple.dock launchanim -bool false

# don’t group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool false

# don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Finder                                                                      #
###############################################################################
_info 'Changing Finder settings...'

# finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# finder: disable the 'Are you sure you want to open this application?'
defaults write com.apple.LaunchServices LSQuarantine -bool false

# finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# finder: show path bar
defaults write com.apple.finder ShowPathbar -bool false

# finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool false

# finder: show the ~/Library folder
chflags nohidden ~/Library

# finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# _info 'Allowing Finder quitting via ⌘ + Q'
defaults write com.apple.finder QuitMenuItem -bool true || _error ''

# when performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'

# disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# automatically open a new finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# finder: set preferred view style
defaults write com.apple.finder FXPreferredViewStyle clmv
rm -rf ~/.DS_Store

# finder: group by
defaults write com.apple.Finder FXPreferredGroupBy Tags

# finder: sort group by
defaults write com.apple.Finder FXArrangeGroupViewBy Name

# keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# saving to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# use collum view in all finder windows by default || `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string 'icnv'

# use collum view in all search view windows by default || `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredSearchViewStyle -string 'icnv'

# use collum view in all search view windows by default || `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredSearchViewStyleVersion -string 'icnv'

# use collum view in all icloud windows by default || `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder ICloudViewSettings -string 'icnv'

# disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# set default path for finder
defaults write com.apple.finder NewWindowTarget -string 'PfLo'
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

###############################################################################
# General UI/UX                                                               #
###############################################################################
_info 'Changing General UI/UX settings...'

# menu bar: hide the useless Time Machine and Volume icons
defaults write com.apple.systemuiserver menuExtras -array '/System/Library/CoreServices/Menu Extras/Bluetooth.menu' '/System/Library/CoreServices/Menu Extras/AirPort.menu' '/System/Library/CoreServices/Menu Extras/Battery.menu' '/System/Library/CoreServices/Menu Extras/Clock.menu'

# always show scrollbars Options: `WhenScrolling`, `Automatic`, `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string 'WhenScrolling'

# disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string 'none'

# disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null

# disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# disabling system-wide resume
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# disable the “reopen windows when logging back in” dialog box (Leaves default to reopen windows)
defaults write com.apple.loginwindow TALLogoutSavesState -bool false
defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false

###############################################################################
# Hot Corners                                                                 #
###############################################################################
_info 'Changing Hot Corners settings...'

# hot corners top right  → Mission Control
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0

# hot corners bottom left → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 11
defaults write com.apple.dock wvous-bl-modifier -int 0

####################################################################################
# iCal                                                                             #
####################################################################################
_info 'Changing iCal settings...'

# enable the debug menu in iCal (pre-10.8)
defaults write com.apple.iCal IncludeDebugMenu -bool true

########################################################################################
# iTunes                                                                               #
########################################################################################
_info 'Changing iTunes settings...'

# Disable the Ping sidebar in iTunes
defaults write com.apple.iTunes disablePingSidebar -bool true

# Disable all the other Ping stuff in iTunes
defaults write com.apple.iTunes disablePing -bool true

# stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null

#######################################################################################
# Keyboard                                                                            #
#######################################################################################
_info 'Changing Keyboard settings...'

# disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# set blazingly fast key repeat rate.
defaults write NSGlobalDomain KeyRepeat -int 1

# set blazingly fast initial key repeat rate.
defaults write NSGlobalDomain InitialKeyRepeat -int 12

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Launchpad                                                                   #
###############################################################################
_info 'Changing Launchpad settings...'

# add iOS Simulator to Launchpad
sudo ln -sf '/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app' '/Applications/Simulator.app'

###############################################################################
# Mac App Store                                                               #
###############################################################################
_info 'Changing Mac App Store settings...'

# enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

# allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

###############################################################################
# Mail                                                                        #
###############################################################################
_info 'Changing Mail settings...'

# copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write com.apple.mail NSUserKeyEquivalents -dict-add 'Send' '@\U21a9'

# disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# disable automatic spell checking
defaults write com.apple.mail SpellCheckingBehavior -string 'NoSpellCheckingEnabled'

###############################################################################
# Messages                                                                    #
###############################################################################
_info 'Changing Messages settings...'

# disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add 'automaticQuoteSubstitutionEnabled' -bool false

# disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add 'continuousSpellCheckingEnabled' -bool false

###############################################################################
# Network                                                                     #
###############################################################################
_info 'Changing Network settings...'

# use AirDrop over every interface
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

###############################################################################
# Safari & WebKit                                                             #
###############################################################################
_info 'Changing Safari & WebKit settings...'

# privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# set safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string 'about:blank'

# prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar '()'

# Enable the develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# disable plug-ins
defaults write com.apple.Safari WebKitPluginsEnabled -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool true

# disable Java
# defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

# block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

# disable auto-playing video
defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false
defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false
defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false

# enable “do not track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

###############################################################################
# Spotlight                                                                   #
###############################################################################
_info 'Changing Spotlight settings...'

# change indexing order and disable some file types
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "FONTS";}' \
	'{"enabled" = 0;"name" = "DOCUMENTS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "IMAGES";}' \
	'{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MUSIC";}' \
	'{"enabled" = 0;"name" = "MOVIES";}' \
	'{"enabled" = 0;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 0;"name" = "SPREADSHEETS";}' \
	'{"enabled" = 0;"name" = "SOURCE";}'
# load new settings before rebuilding the index
killall mds >/dev/null 2>&1
# make sure indexing is enabled for the main volume
sudo mdutil -i on / >/dev/null
# rebuild the index from scratch
sudo mdutil -E / >/dev/null

###############################################################################
# Terminal                                                                    #
###############################################################################
_info 'Changing Terminal settings...'

_info 'Allowing only UTF-8 in Terminal'
defaults write com.apple.terminal StringEncodings -array 4 || _error ''

_info 'Enabling Secure Keyboard Entry in Terminal'
defaults write com.apple.terminal SecureKeyboardEntry -bool true || _error ''

_info 'Disabling line marks in Terminal'
defaults write com.apple.Terminal ShowLineMarks -int 0 || _error ''

####################################################################################
# TextEdit                                                                         #
####################################################################################
_info 'Changing textEdit settings...'

# use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

###############################################################################
# Time Machine                                                                #
###############################################################################
_info 'Changing Time Machine settings...'

# prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

#######################################################################################
# Trackpad                                                                            #
#######################################################################################
_info 'Changing Trackpad settings...'

# _info 'Disabling the Launchpad gesture (pinch with thumb and three fingers)'
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0 || _error ''

# disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false || _error ''

###############################################################################
# Kill affected applications                                                  #
###############################################################################
_info 'Kill affected applications...'

for app in 'Activity Monitor' \
	'Address Book' \
	'Calendar' \
	'cfprefsd' \
	'Contacts' \
	'Dock' \
	'Finder' \
	'iCal' \
	'iTunes' \
	'Mail' \
	'Messages' \
	'Photos' \
	'Safari' \
	'Spotlight' \
	'SystemUIServer' \
	'Terminal' \
	'TextEdit'; do
	killall "${app}" >/dev/null 2>&1
done

_info 'Done. Note that some of these changes require a logout/restart to take effect.'
