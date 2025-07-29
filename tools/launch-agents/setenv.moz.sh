#!/usr/bin/env bash

# create/copy a plist file to macos library and load it with launchctl. 
# used as a fix for launching zen browser with skhd (prevents opening safe mode)

BIN_NAME=$(basename "$0")

sub_help() {
  echo "Usage: $BIN_NAME <command>"
  echo
  echo "Commands:"
  echo "   load            Copies file and runs launchctl load/bootout"
  echo "   unload          Removes file and runs launchctl unload"
  echo "   create          Creates plist file and runs launchctl load"
}

# set the plist file location
SETENV_MOZ="$HOME/Library/LaunchAgents/setenv.moz.plist"

sub_load() {
  # check if the plist is loaded, and load it if not
  if ! launchctl list | grep -q "$SETENV_MOZ"; then
    echo "copying $SETENV_MOZ..."
    cp $SETENV_MOZ "$HOME/Library/LaunchAgents/"

    echo "loading $SETENV_MOZ..."
    launchctl load -w $SETENV_MOZ
    # launchctl bootout gui/"$(id -u)" ~/Library/LaunchAgents/setenv.moz

    echo "$SETENV_MOZ loaded."
  fi
}

sub_unload() {
  echo "removing $SETENV_MOZ..."
  rm $SETENV_MOZ

  echo "unsetting $SETENV_MOZ..."
  launchctl unsetenv.moz.plist

  echo "$SETENV_MOZ removed and unloaded."
}

sub_create_file() {
  if [ ! -f "$SETENV_MOZ" ]; then
    echo "Creating $SETENV_MOZ..."
    cat <<EOF >"$SETENV_MOZ"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>setenv.moz</string>
    <key>ProgramArguments</key>
    <array>
      <string>/bin/launchctl</string>
      <string>setenv</string>
      <string>MOZ_DISABLE_SAFE_MODE_KEY</string>
      <string>1</string>
    </array>
    <key>RunAtLoad</key>
    <true />
    <key>ServiceIPC</key>
    <false />
  </dict>
</plist>
EOF
    echo "created $SETENV_MOZ."
  fi
}

case $COMMAND_NAME in
"" | "-h" | "--help")
  sub_help
  ;;
*)
  shift
  sub_"${COMMAND_NAME}" "$@"
  if [ $? = 127 ]; then
    info "'$COMMAND_NAME' is not a known command or has errors." >&2
    sub_help
    exit 1
  fi
  ;;
esac
