#!/usr/bin/env bash

# Opens or focuses a VSCodium window and hides Ghostty.

set -u

app_to_open="VSCodium"
app_to_hide="Ghostty"

open -a "$app_to_open.app"

yabai -m query --windows |
  jq -r --arg app "$app_to_open" 'map(select(.app == $app)) | .[0].id' |
  while read -r id; do
    osascript -e "
      tell application \"System Events\"
	      set runningApplications to name of every process whose background only is false
      end tell
      set AppName to \"$app_to_hide\"
      tell application \"System Events\"
	      set visible of application process AppName to false
      end tell
      return runningApplications
      "
    yabai -m window --focus "$id"
  done
