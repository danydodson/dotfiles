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
	sudo cp ./config/system/hosts /etc/hosts && _ok 'overwrote hosts'
else
	_ok 'skipped'
fi

# Close any open System Preferences panes
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# Activity Monitor                                                            #
###############################################################################
_info 'Changing Activity Monitor settings...'

# visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5 || _error ''

# show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0 || _error ''

# sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string 'CPUUsage' || _error ''
defaults write com.apple.ActivityMonitor SortDirection -int 0 || _error ''

####################################################################################
# Address Book                                                                     #
####################################################################################
_info 'Changing Address Book settings...'

# Address Book: enable the debug menu in Address Book
defaults write com.apple.addressbook ABShowDebugMenu -bool true || _error ''

#######################################################################################
# Bluetooth Accessories                                                               #
#######################################################################################
_info 'Changing Bluetooth settings...'

# bluetooth: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true || _error ''

# bluetooth: increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent 'Apple Bitpool Min (editable)' -int 40 || _error ''

####################################################################################
# Disk Utility                                                                     #
####################################################################################
_info 'Changing Disc Utility settings...'

# disk utility: enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true || _error ''
defaults write com.apple.DiskUtility advanced-image-options -bool true || _error ''

###############################################################################
# Dock                                                                        #
###############################################################################
_info 'Changing Dock settings...'

# dock: minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true || _error ''

# dock: enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true || _error ''

# dock: show indicator lights for open applications in the dock
defaults write com.apple.dock show-process-indicators -bool true || _error ''

# dock: automatically hide and show the dock
defaults write com.apple.dock autohide -bool true || _error ''

# dock: don’t animate opening applications from the dock
defaults write com.apple.dock launchanim -bool false || _error ''

# dock: don’t group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool false || _error ''

# dock: don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false || _error ''

# dock: don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false || _error ''

# dock: speed up mission control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

###############################################################################
# Finder                                                                      #
###############################################################################
_info 'Changing Finder settings...'

# finder: choose the size of Finder sidebar icons
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "1" || _error ''

# finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true || _error ''

# finder: disable the 'Are you sure you want to open this application?'
defaults write com.apple.LaunchServices LSQuarantine -bool false || _error ''

# finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true || _error ''

# finder: show path bar
defaults write com.apple.finder ShowPathbar -bool false || _error ''

# finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool false || _error ''

# finder: show the ~/Library folder
chflags nohidden ~/Library || _error ''

# finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true || _error ''

# finder: display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool false || _error ''

# finder: allowing finder quitting via ⌘ + Q
defaults write com.apple.finder QuitMenuItem -bool true || _error ''

# finder: when performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf' || _error ''

# finder: disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false || _error ''

# finder: enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true || _error ''

# finder: remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0 || _error ''

# finder: avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true || _error ''
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true || _error ''

# finder: disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true || _error ''
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true || _error ''
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true || _error ''

# finder: automatically open a new finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true || _error ''
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true || _error ''
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true || _error ''

# finder: expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true || _error ''

# finder: set preferred view style
defaults write com.apple.finder FXPreferredViewStyle clmv || _error ''
rm -rf ~/.DS_Store

# finder: group by
defaults write com.apple.Finder FXPreferredGroupBy Tags || _error ''

# finder: sort group by
defaults write com.apple.Finder FXArrangeGroupViewBy Type || _error ''

# finder: keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true || _error ''

# finder: show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true || _error ''

# finder: saving to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false || _error ''

# finder: use collum view in all finder windows by default || `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string 'clmv' || _error ''

# finder: use collum view in all search view windows by default || `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredSearchViewStyle -string 'clmv' || _error ''

# finder: use collum view in all search view windows by default || `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredSearchViewStyleVersion -string 'icnv' || _error ''

# finder: use collum view in all icloud windows by default || `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder ICloudViewSettings -string 'clmv' || _error ''

# finder: disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false || _error ''

# finder: set default path for finder
defaults write com.apple.finder NewWindowTarget -string 'PfLo' || _error ''
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}" || _error ''

###############################################################################
# General UI/UX                                                               #
###############################################################################
_info 'Changing General UI/UX settings...'

# UI/UX: hide the useless Time Machine and Volume icons
defaults write com.apple.systemuiserver menuExtras -array '/System/Library/CoreServices/Menu Extras/Bluetooth.menu' '/System/Library/CoreServices/Menu Extras/AirPort.menu' '/System/Library/CoreServices/Menu Extras/Battery.menu' '/System/Library/CoreServices/Menu Extras/Clock.menu' || _error ''

# UI/UX: always show scrollbars Options: `WhenScrolling`, `Automatic`, `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string 'WhenScrolling' || _error ''

# UI/UX: disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true || _error ''

# UI/UX: disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string 'none' || _error ''

# UI/UX: disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false || _error ''

# UI/UX: reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName || _error ''

# UI/UX: disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null || _error ''

# UI/UX: disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false || _error ''

# UI/UX: disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false || _error ''

# UI/UX: disabling system-wide resume
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false || _error ''

# UI/UX: disable the “reopen windows when logging back in” dialog box (Leaves default to reopen windows)
defaults write com.apple.loginwindow TALLogoutSavesState -bool false || _error ''
defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false || _error ''

###############################################################################
# Hot Corners                                                                 #
###############################################################################
_info 'Changing Hot Corners settings...'

# hot corners: top right → Mission Control
defaults write com.apple.dock wvous-tr-corner -int 2 || _error ''
defaults write com.apple.dock wvous-tr-modifier -int 0 || _error ''

# hot corners: bottom left → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 11 || _error ''
defaults write com.apple.dock wvous-bl-modifier -int 0 || _error ''

####################################################################################
# iCal                                                                             #
####################################################################################
_info 'Changing iCal settings...'

# iCal: enable the debug menu in iCal (pre-10.8)
defaults write com.apple.iCal IncludeDebugMenu -bool true || _error ''

########################################################################################
# iTunes                                                                               #
########################################################################################
_info 'Changing iTunes settings...'

# iTunes: disable the Ping sidebar in iTunes
defaults write com.apple.iTunes disablePingSidebar -bool true || _error ''

# iTunes: disable all the other Ping stuff in iTunes
defaults write com.apple.iTunes disablePing -bool true || _error ''

# iTunes: stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null || _error ''

#######################################################################################
# Keyboard                                                                            #
#######################################################################################
_info 'Changing Keyboard settings...'

# keyboard: Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# keyboard: disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false || _error ''

# keyboard: set blazingly fast key repeat rate.
defaults write NSGlobalDomain KeyRepeat -int 1 || _error ''
defaults write NSGlobalDomain InitialKeyRepeat -int 10 || _error ''

# keyboard: disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false || _error ''

###############################################################################
# Launchpad                                                                   #
###############################################################################
_info 'Changing Launchpad settings...'

# launchpad: add iOS Simulator to Launchpad
sudo ln -sf '/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app' '/Applications/Simulator.app' || _error ''

###############################################################################
# Mac App Store                                                               #
###############################################################################
_info 'Changing Mac App Store settings...'

# app store: enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true || _error ''

# app store: enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true || _error ''

# app store: enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true || _error ''

# app store: check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1 || _error ''

# app store: download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1 || _error ''

# app store: install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1 || _error ''

# app store: turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true || _error ''

# app store: allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true || _error ''

###############################################################################
# Mail                                                                        #
###############################################################################
_info 'Changing Mail settings...'

# mail: copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false || _error ''

# mail: add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write com.apple.mail NSUserKeyEquivalents -dict-add 'Send' '@\U21a9' || _error ''

# mail: disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true || _error ''

# mail: disable automatic spell checking
defaults write com.apple.mail SpellCheckingBehavior -string 'NoSpellCheckingEnabled' || _error ''

###############################################################################
# Messages                                                                    #
###############################################################################
_info 'Changing Messages settings...'

# messages: disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add 'automaticQuoteSubstitutionEnabled' -bool false || _error ''

# messages: disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add 'continuousSpellCheckingEnabled' -bool false || _error ''

###############################################################################
# Network                                                                     #
###############################################################################
_info 'Changing Network settings...'

# network: use AirDrop over every interface
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true || _error ''

###############################################################################
# Safari & WebKit                                                             #
###############################################################################
_info 'Changing Safari & WebKit settings...'

# safari: privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false || _error ''
defaults write com.apple.Safari SuppressSearchSuggestions -bool true || _error ''

# safari: press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true || _error ''
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true || _error ''

# safari: show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true || _error ''

# safari: set safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string 'about:blank' || _error ''

# safari: prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false || _error ''

# safari: hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false || _error ''

# safari: hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false || _error ''

# safari: disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2 || _error ''

# safari: enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true || _error ''

# safari: make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false || _error ''

# safari: remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar '()' || _error ''

# safari: enable the develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true || _error ''
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true || _error ''
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true || _error ''

# safari: add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true || _error ''

# safari: enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true || _error ''

# safari: disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false || _error ''

# safari: disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false || _error ''
defaults write com.apple.Safari AutoFillPasswords -bool false || _error ''
defaults write com.apple.Safari AutoFillCreditCardData -bool false || _error ''
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false || _error ''

# safari: warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true || _error ''

# safari: disable plug-ins
defaults write com.apple.Safari WebKitPluginsEnabled -bool true || _error ''
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool true || _error ''

# safari: disable java. defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false || _error ''
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false || _error ''

# safari: block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false || _error ''
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false || _error ''

# safari: disable auto-playing video
defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false || _error ''
defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false || _error ''
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false || _error ''
defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false || _error ''

# safari: enable “do not track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true || _error ''

# safari: update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true || _error ''

###############################################################################
# Spotlight                                                                   #
###############################################################################
_info 'Changing Spotlight settings...'

# spotlight: change indexing order and disable some file types
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

# spotlight: load new settings before rebuilding the index
killall mds >/dev/null 2>&1

# spotlight: make sure indexing is enabled for the main volume
sudo mdutil -i on / >/dev/null

# spotlight: rebuild the index from scratch
sudo mdutil -E / >/dev/null

###############################################################################
# Terminal                                                                    #
###############################################################################
_info 'Changing Terminal settings...'

# terminal: allowing only UTF-8 in terminal
defaults write com.apple.terminal StringEncodings -array 4 || _error ''

# terminal: enabling secure keyboard entry in terminal
defaults write com.apple.terminal SecureKeyboardEntry -bool true || _error ''

# terminal: disabling line marks in terminal
defaults write com.apple.Terminal ShowLineMarks -int 0 || _error ''

####################################################################################
# TextEdit                                                                         #
####################################################################################
_info 'Changing textEdit settings...'

# text-edit: use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0 || _error ''

# text-edit: open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4 || _error ''
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4 || _error ''

###############################################################################
# Time Machine                                                                #
###############################################################################
_info 'Changing Time Machine settings...'

# time-machine: prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true || _error ''

#######################################################################################
# Trackpad                                                                            #
#######################################################################################
_info 'Changing Trackpad settings...'

# trackpad: Disabling the Launchpad gesture (pinch with thumb and three fingers)
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0 || _error ''

# trackpad: disable “natural” (Lion-style) scrolling
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
