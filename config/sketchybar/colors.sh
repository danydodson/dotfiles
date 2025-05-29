#!/usr/bin/env bash

ONEDARK=(
    blue "#61AFEF"
    teal "#94e2d5"
    cyan "#56B6C2"
    grey "#5d626e"
    green "#98C379"
    yellow "#eed49f"
    orange "#D19A66"
    red "#E06C75"
    purple "#C678DD"
    maroon "#d3869b"
    black "#1E2127"
    trueblack "#1c1c1c"
    white "#ECEFF4"
)

COLORS=("${ONEDARK[@]}")

getcolor() {
    COLOR_NAME=$1
    local COLOR=""

    if [[ -z $2 ]]; then
        OPACITY=100
    else
        OPACITY=$2
    fi

    # loop through the array to find the color hex by name
    for ((i = 0; i < ${#COLORS[@]}; i += 2)); do
        if [[ "${COLORS[i]}" == "$COLOR_NAME" ]]; then
            COLOR="${COLORS[i + 1]}"
            break
        fi
    done

    # check if color was found
    if [[ -z $COLOR ]]; then
        echo "Invalid color name: $COLOR_NAME" >&2
        return 1
    fi

    echo "$(PERCENT2HEX "$OPACITY")${COLOR:1}"
}

PERCENT2HEX() {
    local PERCENTAGE=$1
    local DECIMAL=$(((PERCENTAGE * 255) / 100))
    printf "0x%02X\n" "$DECIMAL"
}

# color Tokens
BAR_COLOR=$(getcolor black)
BAR_BORDER_COLOR=$(getcolor black 0)
BAR_COLOR_TRANSPARENT=$(getcolor black 40)
HIGHLIGHT=$(getcolor cyan)
HIGHLIGHT_75=$(getcolor cyan 75)
HIGHLIGHT_50=$(getcolor cyan 50)
HIGHLIGHT_25=$(getcolor cyan 25)
HIGHLIGHT_10=$(getcolor cyan 10)
ICON_COLOR=$(getcolor white)
ICON_COLOR_INACTIVE=$(getcolor white 25)
LABEL_COLOR=$(getcolor white 75)
LABEL_COLOR_NEGATIVE=$(getcolor black)
POPUP_BACKGROUND_COLOR=$(getcolor black 75)
POPUP_BORDER_COLOR=$(getcolor black 0)
SHADOW_COLOR=$(getcolor black)
TRANSPARENT=$(getcolor black 0)
