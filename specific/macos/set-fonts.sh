# #!/bin/bash
# # 
# # copy fonts to library folder
# # 

# # close any open System Preferences panes
# osascript -e 'tell application "System Preferences" to quit'

# # ask for the administrator password upfront
# sudo -v

# # keep-alive: update existing `sudo` time stamp until `.macos` has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# # clear font cache for current user
# atsutil databases -removeUser && \
# atsutil server -shutdown && \
# atsutil server -ping

# ###############################################################################
# # Copy fonts to library                                                       #
# ###############################################################################

# # copy fonts
# cp -v ~/Dropbox/Media/Fonts/Hoefler-and-Co/**/*.otf ~/Library/Fonts

# ###############################################################################
# # Kill affected applications                                                  #
# ###############################################################################

# for app in "Finder" \
#   "Font Book"; do
# 	killall "${app}" > /dev/null 2>&1
# done

# echo "Done. User fonts copied to library."
