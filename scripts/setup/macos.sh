#!/usr/bin/env bash

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }
__err() { printf '\033[0;31m[ERR] \033[0;31m%s\033[0;m\n' "$1"; }

###############################################################################
# Prompt user input                                                           #
###############################################################################

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing sudo time stamp until script has finished
while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

# Close any open System Preferences panes
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# Activity Monitor                                                            #
###############################################################################
__info 'Changing Activity Monitor settings...'

# visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5 || __err ''

# show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0 || __err ''

# sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string 'CPUUsage' || __err ''
defaults write com.apple.ActivityMonitor SortDirection -int 0 || __err ''

####################################################################################
# Address Book                                                                     #
####################################################################################
__info 'Changing Address Book settings...'

# Address Book: enable the debug menu in Address Book
defaults write com.apple.addressbook ABShowDebugMenu -bool true || __err ''

#######################################################################################
# Bluetooth Accessories                                                               #
#######################################################################################
__info 'Changing Bluetooth settings...'

# bluetooth: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true || __err ''

# bluetooth: increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent 'Apple Bitpool Min (editable)' -int 40 || __err ''

####################################################################################
# Disk Utility                                                                     #
####################################################################################
__info 'Changing Disc Utility settings...'

# disk utility: enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true || __err ''
defaults write com.apple.DiskUtility advanced-image-options -bool true || __err ''

###############################################################################
# Dock                                                                        #
###############################################################################
__info 'Changing Dock settings...'

# dock: minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true || __err ''

# dock: enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true || __err ''

# dock: show indicator lights for open applications in the dock
defaults write com.apple.dock show-process-indicators -bool true || __err ''

# dock: automatically hide and show the dock
defaults write com.apple.dock autohide -bool true || __err ''

# dock: don’t animate opening applications from the dock
defaults write com.apple.dock launchanim -bool false || __err ''

# dock: don’t group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool false || __err ''

# dock: don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false || __err ''

# dock: don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false || __err ''

# dock: speed up mission control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

###############################################################################
# Finder                                                                      #
###############################################################################
__info 'Changing Finder settings...'

# finder: choose the size of Finder sidebar icons
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "2" || __err ''

# finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true || __err ''

# finder: disable the 'Are you sure you want to open this application?'
defaults write com.apple.LaunchServices LSQuarantine -bool false || __err ''

# finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true || __err ''

# finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true || __err ''

# finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool false || __err ''

# finder: show the ~/Library folder
# chflags nohidden ~/Library || __err ''

# finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true || __err ''

# finder: display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool false || __err ''

# finder: allowing finder quitting via ⌘ + Q
defaults write com.apple.finder QuitMenuItem -bool true || __err ''

# finder: when performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf' || __err ''

# finder: disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false || __err ''

# finder: enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true || __err ''

# finder: remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0 || __err ''

# finder: avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true || __err ''
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true || __err ''

# finder: disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true || __err ''
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true || __err ''
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true || __err ''

# finder: automatically open a new finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true || __err ''
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true || __err ''
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true || __err ''

# finder: expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true || __err ''

# finder: set preferred view style
defaults write com.apple.finder FXPreferredViewStyle clmv || __err ''
rm -rf ~/.DS_Store

# finder: group by
defaults write com.apple.Finder FXPreferredGroupBy Tags || __err ''

# finder: sort group by
defaults write com.apple.Finder FXArrangeGroupViewBy Type || __err ''

# finder: keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true || __err ''

# finder: show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true || __err ''

# finder: saving to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false || __err ''

# finder: use collum view in all finder windows by default || `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string 'clmv' || __err ''

# finder: use collum view in all search view windows by default || `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredSearchViewStyle -string 'clmv' || __err ''

# finder: use collum view in all search view windows by default || `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredSearchViewStyleVersion -string 'icnv' || __err ''

# finder: use collum view in all icloud windows by default || `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder ICloudViewSettings -string 'clmv' || __err ''

# finder: disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false || __err ''

# finder: set default path for finder
defaults write com.apple.finder NewWindowTarget -string 'PfLo' || __err ''
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}" || __err ''

###############################################################################
# General UI/UX                                                               #
###############################################################################
__info 'Changing General UI/UX settings...'

# UI/UX: hide the useless Time Machine and Volume icons
defaults write com.apple.systemuiserver menuExtras -array '/System/Library/CoreServices/Menu Extras/Bluetooth.menu' '/System/Library/CoreServices/Menu Extras/AirPort.menu' '/System/Library/CoreServices/Menu Extras/Battery.menu' '/System/Library/CoreServices/Menu Extras/Clock.menu' || __err ''

# UI/UX: always show scrollbars Options: `WhenScrolling`, `Automatic`, `Always`
defaults write NSGlobalDomain AppleShowScrollBars -string 'WhenScrolling' || __err ''

# UI/UX: disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true || __err ''

# UI/UX: disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string 'none' || __err ''

# UI/UX: disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false || __err ''

# UI/UX: reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName || __err ''

# UI/UX: disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null || __err ''

# UI/UX: disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false || __err ''

# UI/UX: disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false || __err ''

# UI/UX: disabling system-wide resume
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false || __err ''

# UI/UX: disable the “reopen windows when logging back in” dialog box (Leaves default to reopen windows)
defaults write com.apple.loginwindow TALLogoutSavesState -bool false || __err ''
defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false || __err ''

###############################################################################
# Hot Corners                                                                 #
###############################################################################
__info 'Changing Hot Corners settings...'

# hot corners: top right → Mission Control
defaults write com.apple.dock wvous-tr-corner -int 2 || __err ''
defaults write com.apple.dock wvous-tr-modifier -int 0 || __err ''

# hot corners: bottom left → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 11 || __err ''
defaults write com.apple.dock wvous-bl-modifier -int 0 || __err ''

####################################################################################
# iCal                                                                             #
####################################################################################
__info 'Changing iCal settings...'

# iCal: enable the debug menu in iCal (pre-10.8)
defaults write com.apple.iCal IncludeDebugMenu -bool true || __err ''

########################################################################################
# iTunes                                                                               #
########################################################################################
__info 'Changing iTunes settings...'

# iTunes: disable the Ping sidebar in iTunes
defaults write com.apple.iTunes disablePingSidebar -bool true || __err ''

# iTunes: disable all the other Ping stuff in iTunes
defaults write com.apple.iTunes disablePing -bool true || __err ''

# iTunes: stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null || __err ''

#######################################################################################
# Keyboard                                                                            #
#######################################################################################
__info 'Changing Keyboard settings...'

# keyboard: Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# keyboard: disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false || __err ''

# keyboard: set blazingly fast key repeat rate.
defaults write NSGlobalDomain KeyRepeat -int 1 || __err ''
defaults write NSGlobalDomain InitialKeyRepeat -int 10 || __err ''

# keyboard: disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false || __err ''

###############################################################################
# Launchpad                                                                   #
###############################################################################
__info 'Changing Launchpad settings...'

# launchpad: add iOS Simulator to Launchpad
sudo ln -sf '/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app' '/Applications/Simulator.app' || __err ''

###############################################################################
# Mac App Store                                                               #
###############################################################################
__info 'Changing Mac App Store settings...'

# app store: enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true || __err ''

# app store: enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true || __err ''

# app store: enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true || __err ''

# app store: check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1 || __err ''

# app store: download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1 || __err ''

# app store: install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1 || __err ''

# app store: turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true || __err ''

# app store: allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool true || __err ''

###############################################################################
# Mail                                                                        #
###############################################################################
__info 'Changing Mail settings...'

# mail: copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false || __err ''

# mail: add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write com.apple.mail NSUserKeyEquivalents -dict-add 'Send' '@\U21a9' || __err ''

# mail: disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true || __err ''

# mail: disable automatic spell checking
defaults write com.apple.mail SpellCheckingBehavior -string 'NoSpellCheckingEnabled' || __err ''

###############################################################################
# Messages                                                                    #
###############################################################################
__info 'Changing Messages settings...'

# messages: disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add 'automaticQuoteSubstitutionEnabled' -bool false || __err ''

# messages: disable continuous spell checking
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add 'continuousSpellCheckingEnabled' -bool false || __err ''

###############################################################################
# Network                                                                     #
###############################################################################
__info 'Changing Network settings...'

# network: use AirDrop over every interface
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true || __err ''

###############################################################################
# Photos
###############################################################################
__info 'Changing Photos settings...'

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Preview
###############################################################################
__info 'Changing Previews settings...'

# Don't remember open files
defaults write com.apple.Preview NSQuitAlwaysKeepsWindows -bool false

###############################################################################
# QuickTime
###############################################################################
__info 'Changing Quicktime settings...'

# Auto-play videos when opened with QuickTime Player
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

# Don't remember open files
defaults write com.apple.QuickTimePlayerX NSQuitAlwaysKeepsWindows -bool false

###############################################################################
# Safari & WebKit                                                             #
###############################################################################
__info 'Changing Safari & WebKit settings...'

# safari: privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false || __err ''
defaults write com.apple.Safari SuppressSearchSuggestions -bool true || __err ''

# safari: press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true || __err ''
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true || __err ''

# safari: show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true || __err ''

# safari: set safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string 'about:blank' || __err ''

# safari: prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false || __err ''

# safari: hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false || __err ''

# safari: hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false || __err ''

# safari: disable Safari’s thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2 || __err ''

# safari: enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true || __err ''

# safari: make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false || __err ''

# safari: remove useless icons from Safari’s bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar '()' || __err ''

# safari: enable the develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true || __err ''
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true || __err ''
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true || __err ''

# safari: add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true || __err ''

# safari: enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true || __err ''

# safari: disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false || __err ''

# safari: disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false || __err ''
defaults write com.apple.Safari AutoFillPasswords -bool false || __err ''
defaults write com.apple.Safari AutoFillCreditCardData -bool false || __err ''
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false || __err ''

# safari: warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true || __err ''

# safari: disable plug-ins
defaults write com.apple.Safari WebKitPluginsEnabled -bool true || __err ''
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool true || __err ''

# safari: disable java. defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false || __err ''
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false || __err ''

# safari: block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false || __err ''
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false || __err ''

# safari: disable auto-playing video
defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false || __err ''
defaults write com.apple.SafariTechnologyPreview WebKitMediaPlaybackAllowsInline -bool false || __err ''
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false || __err ''
defaults write com.apple.SafariTechnologyPreview com.apple.Safari.ContentPageGroupIdentifier.WebKit2AllowsInlineMediaPlayback -bool false || __err ''

# safari: enable “do not track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true || __err ''

# safari: update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true || __err ''

###############################################################################
# Spotlight                                                                   #
###############################################################################
__info 'Changing Spotlight settings...'

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
__info 'Changing Terminal settings...'

# terminal: allowing only UTF-8 in terminal
defaults write com.apple.terminal StringEncodings -array 4 || __err ''

# terminal: enabling secure keyboard entry in terminal
defaults write com.apple.terminal SecureKeyboardEntry -bool true || __err ''

# terminal: disabling line marks in terminal
defaults write com.apple.Terminal ShowLineMarks -int 0 || __err ''

####################################################################################
# TextEdit                                                                         #
####################################################################################
__info 'Changing textEdit settings...'

# text-edit: use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0 || __err ''

# text-edit: open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4 || __err ''
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4 || __err ''

###############################################################################
# Time Machine                                                                #
###############################################################################
__info 'Changing Time Machine settings...'

# time-machine: prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true || __err ''

#######################################################################################
# Trackpad                                                                            #
#######################################################################################
__info 'Changing Trackpad settings...'

# trackpad: Disabling the Launchpad gesture (pinch with thumb and three fingers)
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0 || __err ''

# trackpad: disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false || __err ''

###############################################################################
# Kill affected applications                                                  #
###############################################################################
__info 'Kill affected applications...'

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
	'Preview' \
	'Quicktime' \
	'Safari' \
	'Spotlight' \
	'SystemUIServer' \
	'Terminal' \
	'TextEdit'; do
	killall "${app}" >/dev/null 2>&1
done

__info 'Done. Note that some of these changes require a logout/restart to take effect.'
