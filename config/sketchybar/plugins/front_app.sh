#!/usr/bin/env zsh

ICON_PADDING_RIGHT=5

case $INFO in
"Zen")
    ICON_PADDING_RIGHT=5
    ICON=
    ;;
"VSCodium")
    ICON_PADDING_RIGHT=4
    ICON=󰨞
    ;;
"Calendar")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"Discord")
    ICON=
    ;;
"FaceTime")
    ICON_PADDING_RIGHT=5
    ICON=
    ;;
"Finder")
    ICON=󰀶
    ;;
"Google Chrome")
    ICON_PADDING_RIGHT=7
    ICON=
    ;;
"IINA")
    ICON_PADDING_RIGHT=4
    ICON=󰕼
    ;;
"Ghostty")
    ICON=
    ;;
"Messages")
    ICON=
    ;;
"Preview")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"PS Remote Play")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"Spotify")
    ICON_PADDING_RIGHT=2
    ICON=
    ;;
"TextEdit")
    ICON_PADDING_RIGHT=4
    ICON=
    ;;
"Transmission")
    ICON_PADDING_RIGHT=3
    ICON=󰶘
    ;;
*)
    ICON_PADDING_RIGHT=2
    ICON=
    ;;
esac

sketchybar --set $NAME icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT
sketchybar --set $NAME.name label="$INFO"
