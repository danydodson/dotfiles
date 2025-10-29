#!/usr/bin/env bash

# Opens or focuses a Ghostty window and hides VSCodium.

set -u

app_to_open="Ghostty"
app_to_hide="VSCodium"

open -a "$app_to_open.app"

yabai -m query --windows |
  jq -r --arg app "$app_to_open" 'map(select(.app == $app)) | .[0].id' |
  while read -r id; do
    osascript -e "
    tell application \"System Events\"
      if exists process \"$app_to_hide\" then
        set visible of application process \"$app_to_hide\" to false
      end if
    end tell
    "
    yabai -m window --focus "$id"
  done
