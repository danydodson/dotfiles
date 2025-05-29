#!/usr/bin/env bash

source "$CONFIG_DIR/styles.sh"

# defaults
spaces=(
  background.corner_radius=4
)

# get all spaces
SPACES=("$(yabai -m query --spaces index | jq -r '.[].index')")

for SID in "${SPACES[@]}"; do
  sketchybar --add space space."$SID" left \
             --set space."$SID" "${spaces[@]}" \
                   script="$PLUGIN_DIR/app_space.sh $SID" \
                   associated_space="$SID" \
                   icon="$SID" \
             --subscribe space."$SID" \
                         mouse.clicked \
                         front_app_switched \
                         space_change \
                         space_windows_change
done