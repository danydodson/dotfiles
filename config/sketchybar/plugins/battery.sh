#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"
TMP="/tmp/drawing_state.txt"

render_item() {
    PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
    CHARGING=$(pmset -g batt | grep 'AC Power')
    COLOR=$ICON_COLOR
    local DRAWING
    DRAWING=$(get_label_state)

    if [ "$PERCENTAGE" = "" ]; then
        exit 0
    fi

    case ${PERCENTAGE} in
    [8-9][0-9] | 100)
        ICON=""
        ICON_COLOR=0xffa6da95
        ;;
    7[0-9])
        ICON=""
        ICON_COLOR=0xffeed49f
        ;;
    [4-6][0-9])
        ICON=""
        ICON_COLOR=0xfff5a97f
        ;;
    [1-3][0-9])
        ICON=""
        ICON_COLOR=0xffee99a0
        ;;
    [0-9])
        ICON=""
        ICON_COLOR=0xffed8796
        ;;
    esac

    if [[ $CHARGING != "" ]]; then
        ICON=""
        COLOR=$(getcolor green)
    fi

    sketchybar --set "$NAME" icon="$ICON" icon.color="$COLOR" label="$PERCENTAGE"% label.color="$LABEL_COLOR" label.drawing="$DRAWING"
}

save_label_state() {
    echo "$(sketchybar --query $NAME | jq -r '.label.drawing')" >"$TMP"
}

get_label_state() {
    if [ -e "$TMP" ]; then
        cat "$TMP"
    else
        echo "off" >"$TMP"
    fi
}

label_toggle() {
    if [[ $(get_label_state) == "on" ]]; then
        DRAWING="off"
    else
        DRAWING="on"
    fi

    sketchybar --set "$NAME" label.drawing=$DRAWING
    save_label_state
}

case "$SENDER" in
"mouse.clicked")
    label_toggle
    ;;
"routine" | "forced" | "power_source_change")
    render_item
    ;;
esac
