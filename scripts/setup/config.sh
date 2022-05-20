#!/bin/bash

# Log Helpers
. "$HOME/Developer/Dotfiles/utilities/helpers.sh"
. "$HOME/Developer/Dotfiles/utilities/pretty.bash"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Google Chrome                                                               #
###############################################################################
 __info "Changing Google Chrome settings..."

# chrome: allow installing user scripts via GitHub or Userscripts.org
defaults write com.google.Chrome ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"

# chrome: disable swipe to go back
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

###############################################################################
# iTerm2                                                                      #
###############################################################################
 __info "Changing iTerm settings..."

# iterm2: disabling prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false ||  __err "defaults write com.googlecode.iterm2"

# iterm2: disabling changing font size with pinch gesture in iTerm
defaults write com.googlecode.iterm2 PinchToChangeFontSizeDisabled -bool true ||  __err "defaults write com.googlecode.iterm2"

###############################################################################
# Transmission                                                                #
###############################################################################
 __info "Changing Transmission settings..."

# transmission:download & upload badges
defaults write org.m0k.transmission BadgeDownloadRate -bool false
defaults write org.m0k.transmission BadgeUploadRate -bool false

# transmission: automatic import
mkdir -p "$HOME/Public/Torrents/Dotfiles"
defaults write org.m0k.transmission AutoImport -bool true
defaults write org.m0k.transmission AutoImportDirectory -string "$HOME/Public/Torrents/Dotfiles"

# transmission: store complete downloads
mkdir -p "$HOME/Public/Torrents/Seeding"
defaults write org.m0k.transmission DownloadLocationConstant -bool true
defaults write org.m0k.transmission DownloadChoice -string "Constant"
defaults write org.m0k.transmission DownloadFolder -string "$HOME/Public/Torrents/Seeding"

# transmission: store incomplete downloads
mkdir -p "$HOME/Public/Torrents/Working"
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "$HOME/Public/Torrents/Working"

# transmission: don’t prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool true

# transmission: trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# transmission: hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false

# transmission: hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

# transmission: link to blocklist
defaults write org.m0k.transmission BlocklistURL -string "https://raw.githubusercontent.com/Naunter/BT_BlockLists/master/bt_blocklists.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true
defaults write org.m0k.transmission BlocklistNew -bool true

# transmission: randomize port on launch
defaults write org.m0k.transmission RandomPort -bool true

# transmission: dont show status bar
defaults write org.m0k.transmission StatusBar -bool false

# transmission: use the small list view
defaults write org.m0k.transmission SmallView -bool true

# transmission: dont show pieces bar
defaults write org.m0k.transmission PiecesBar -bool false

# transmission: dont show filter bar
defaults write org.m0k.transmission FilterBar -bool false

# transmission: dont show availability
defaults write org.m0k.transmission DisplayProgressBarAvailable -bool false

###############################################################################
# Kill affected applications                                                  #
###############################################################################
 __info "Killing affected applications..."

for app in "iTerm" "Google Chrome" "Transmission"; do
  killall "${app}" &>/dev/null
done

 __ok "Done. Note that some of these changes require a logout/restart to take effect."
