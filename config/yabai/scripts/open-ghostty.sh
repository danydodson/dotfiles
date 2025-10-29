#!/usr/bin/env bash

# Opens a new Ghostty window and minimizes all VSCodium windows

# sharpener -r 4;

# Minimize VSCodium using AppleScript
osascript -e '
tell application "System Events"
	set runningApplications to name of every process whose background only is false
end tell

set AppName to "Electron"

tell application "System Events"
	set visible of application process AppName to false
end tell

return runningApplications
'

# Open a new Ghostty window
open -a Ghostty.app
