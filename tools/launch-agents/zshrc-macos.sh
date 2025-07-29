#!/usr/bin/env bash

# This below is to automate the process of creating the
# com.dany.pgh.plist file which will run every X seconds and
# automaticaly push changes to some github repos

# Check if the com.dany.pgh.plist file exists, create it if missing
PLIST_PATH="$HOME/Library/LaunchAgents/com.dany.pgh.plist"
SCRIPT_PATH="$HOME/.dotfiles/tools/400-pgh.sh"

# NOTE: If you modify the StartInterval below, make sure to also change it in
# the ~/.dotfiles/tools/400-pgh.sh script
if [ ! -f "$PLIST_PATH" ]; then
  echo "Creating $PLIST_PATH..."
  cat <<EOF >"$PLIST_PATH"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.dany.pgh.plist</string>
    <key>ProgramArguments</key>
    <array>
      <string>$SCRIPT_PATH</string>
    </array>
    <key>StartInterval</key>
    <integer>180</integer>
    <key>StandardOutPath</key>
    <string>/tmp/pgh.out</string>
    <key>StandardErrorPath</key>
    <string>/tmp/pgh.err</string>
  </dict>
</plist>
EOF
  echo "Created $PLIST_PATH."
fi

# Check if the plist file is loaded, and load it if not
# If you want to verify manually if running, run
# launchctl list | grep -i autopush
# First column (-) means the job is NOT currently running. Normal as our script runs every X seconds
# Second Column (0) means the job ran successfully the last execution, other values mean error
if ! launchctl list | grep -q "com.dany.pgh"; then
  echo "Loading $PLIST_PATH..."
  launchctl load "$PLIST_PATH"
  echo "$PLIST_PATH loaded."
fi

# Automate tmux session cleanup every X hours using a LaunchAgent
# This will create plist file to run the script every X hours
# and log output/errors to /tmp/$PLIST_LABEL.out and /tmp/$PLIST_LABEL.err
# NOTE: If you modify the INTERVAL_SEC below, make sure to also change it in
# the ~/github/dotfiles-latest/tmux/tools/linkarzu/tmuxKillSessions.sh script

# 1 hour = 3600 s
INTERVAL_SEC=7200
PLIST_ID="tmuxKillSessions"
PLIST_NAME="com.dany.$PLIST_ID.plist"
PLIST_LABEL="${PLIST_NAME%.plist}"
PLIST_PATH="$HOME/Library/LaunchAgents/$PLIST_NAME"
SCRIPT_PATH="$HOME/.dotfiles/config/tmux/tools/danydodson/$PLIST_ID.sh"

# Ensure the script file exists
if [ ! -f "$SCRIPT_PATH" ]; then
  echo "Error: $SCRIPT_PATH does not exist."
else
  # If the PLIST file does not exist, create it
  if [ ! -f "$PLIST_PATH" ]; then
    echo "Creating $PLIST_PATH..."
    cat <<EOF >"$PLIST_PATH"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>$PLIST_LABEL</string>
    <key>ProgramArguments</key>
    <array>
      <string>$SCRIPT_PATH</string>
    </array>
    <key>StartInterval</key>
    <integer>$INTERVAL_SEC</integer>
    <key>StandardOutPath</key>
    <string>/tmp/$PLIST_ID.out</string>
    <key>StandardErrorPath</key>
    <string>/tmp/$PLIST_ID.err</string>
  </dict>
</plist>
EOF
  fi
fi

# Check if the plist is loaded, and load it if not
if ! launchctl list | grep -q "$PLIST_LABEL"; then
  echo "Loading $PLIST_PATH..."
  launchctl load "$PLIST_PATH"
  echo "$PLIST_PATH loaded."
fi

# To unload
# launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.linkarzu.tmuxKillSessions
# Not sure why its not unloading it so I just remove the plist file
# rm $PLIST_PATH
