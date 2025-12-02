#!/usr/bin/env bash

#

dmp=~/Library/LaunchAgents/dots.mozilla.plist
sudo chown "$(whoami)" "$dmp"
sudo chmod 644 "$dmp"
launchctl bootout gui/$UID "$dmp" 2>/dev/null
launchctl bootstrap gui/$UID "$dmp"

lmf=/Library/LaunchDaemons/limit.maxfiles.plist
sudo chown root:wheel "$mf"
sudo chmod 644 "$mf"
sudo launchctl bootout system "$mf" 2>/dev/null
sudo launchctl bootstrap system "$mf"

lmp=/Library/LaunchDaemons/limit.maxproc.plist
sudo chown root:wheel "$lmp"
sudo chmod 644 "$lmp"
sudo launchctl bootout system "$lmp" 2>/dev/null
sudo launchctl bootstrap system "$lmp"

echo "A reboot is required..."
