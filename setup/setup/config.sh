#!/bin/bash

# Log Helper
_info() { echo -e "\033[36m[INFO]\033[0m $1"; }
_ok() { echo -e "\033[32m[OK]\033[0m $1"; }
_error() { echo -e "\033[31m[ERROR]\033[0m $1"; }

# DOTFILES="$HOME/Dotfiles"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true sleep 60 kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Google Chrome                                                               #
###############################################################################
_info "Changing Google Chrome settings..."

# allow installing user scripts via GitHub or Userscripts.org
defaults write com.google.Chrome ExtensionInstallSources -array "https://*.github.com/*" "http://userscripts.org/*"

# Disable swipe to go back
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

###############################################################################
# iTerm2                                                                      #
###############################################################################
_info "Changing iTerm settings..."

_info "Disabling prompt when quitting iTerm"
defaults write com.googlecode.iterm2 PromptOnQuit -bool false || _error "defaults write com.googlecode.iterm2"

_info "Disabling changing font size with pinch gesture in iTerm"
defaults write com.googlecode.iterm2 PinchToChangeFontSizeDisabled -bool true || _error "defaults write com.googlecode.iterm2"

# _info "Installing color theme for iTerm (opening file)"
# if [ ! -f "$DOTFILES/config/iterm/Dracula.itermcolors" ]; then
#   open "$DOTFILES/config/iterm/Dracula.itermcolors" && _ok
# fi

# _info "Copy iTerm2.plist"
# rm -rf ~/Library/Preferences/com.googlecode.iterm2.plist
# cp $DOTFILES/iterm/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

# if [ ! -f "${HOME}/.config/iterm2/iterm2_shell_integration.zsh" ]; then
#   _info "Fetching iterm2_shell_integration.zsh..."
#   curl -L https://iterm2.com/shell_integration/zsh -o "${HOME}/.config/iterm2/iterm2_shell_integration.zsh" && _ok
# fi

# if [ ! -f "${HOME}/.config/iterm2/utilities" ]; then
#   _info "Fetching iTerm2 utilities..."
#   curl -LO https://github.com/gnachman/iTerm2-shell-integration/archive/refs/heads/main.zip --output-dir "$DOTFILES/iterm" && _ok
#   unzip "$DOTFILES"/iterm/main.zip "iTerm2-shell-integration-main/utilities/*" -d "$DOTFILES/iterm" && _ok
#   mv "$DOTFILES/iterm/iTerm2-shell-integration-main/utilities" "$HOME/.config/iTerm2" && _ok
#   rm -rf "$DOTFILES"/iterm/iTerm2-shell-integration-main "$DOTFILES"/iterm/main.zip && _ok
# fi

###############################################################################
# Tunnelblick                                                                 #
###############################################################################
# _info "Changing Tunnelblick settings..."

# for opvn in "$HOME"/Dropbox/Tunnelblick/*; do
#   _info "Configuring vpn $opvn"
#   open "$opvn"
# done

###############################################################################
# Transmission                                                                #
###############################################################################
_info "Changing Transmission settings..."

# download & upload badges
defaults write org.m0k.transmission BadgeDownloadRate -bool false
defaults write org.m0k.transmission BadgeUploadRate -bool false

# automatic import
mkdir -p "$HOME/Public/Torrents/Dotfiles"
defaults write org.m0k.transmission AutoImport -bool true
defaults write org.m0k.transmission AutoImportDirectory -string "$HOME/Public/Torrents/Dotfiles"

# store complete downloads
mkdir -p "$HOME/Public/Torrents/Seeding"
defaults write org.m0k.transmission DownloadLocationConstant -bool true
defaults write org.m0k.transmission DownloadChoice -string "Constant"
defaults write org.m0k.transmission DownloadFolder -string "$HOME/Public/Torrents/Seeding"

# store incomplete downloads
mkdir -p "$HOME/Public/Torrents/Working"
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
defaults write org.m0k.transmission IncompleteDownloadFolder -string "$HOME/Public/Torrents/Working"

# don’t prompt for confirmation before downloading
defaults write org.m0k.transmission DownloadAsk -bool true

# trash original torrent files
defaults write org.m0k.transmission DeleteOriginalTorrent -bool true

# hide the donate message
defaults write org.m0k.transmission WarningDonate -bool false

# hide the legal disclaimer
defaults write org.m0k.transmission WarningLegal -bool false

# link to blocklist
defaults write org.m0k.transmission BlocklistURL -string "https://raw.githubusercontent.com/Naunter/BT_BlockLists/master/bt_blocklists.gz"
defaults write org.m0k.transmission BlocklistAutoUpdate -bool true
defaults write org.m0k.transmission BlocklistNew -bool true

# randomize port on launch
defaults write org.m0k.transmission RandomPort -bool true

# dont show status bar
defaults write org.m0k.transmission StatusBar -bool false

# use the small list view
defaults write org.m0k.transmission SmallView -bool true

# dont show pieces bar
defaults write org.m0k.transmission PiecesBar -bool false

# dont show filter bar
defaults write org.m0k.transmission FilterBar -bool false

# dont show availability
defaults write org.m0k.transmission DisplayProgressBarAvailable -bool false

###############################################################################
# Kill affected applications                                                  #
###############################################################################
_info "Killing affected applications..."

for app in "iTerm" "Google Chrome" "Transmission"; do
  killall "${app}" &>/dev/null
done

_ok "Done. Note that some of these changes require a logout/restart to take effect."
