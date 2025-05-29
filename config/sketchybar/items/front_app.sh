#!/usr/bin/env bash

source "$CONFIG_DIR/styles.sh"

front_app=(
  icon.drawing=off
  label.padding_right="$PADDINGS"
  script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left \
           --set front_app "${front_app[@]}" \
           --subscribe front_app space_change space_windows_change front_app_switched