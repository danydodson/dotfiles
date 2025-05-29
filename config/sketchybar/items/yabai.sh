#!/usr/bin/env bash

source "$CONFIG_DIR/styles.sh"

yabai=(
  icon="$ICON_YABAI_GRID"
  icon.padding_left="$PADDINGS"
  icon.padding_right=$((PADDINGS + 2))
  label.padding_right="$PADDINGS"
  script="$CONFIG_DIR/plugins/yabai.sh"
)

sketchybar --add event update_yabai_icon

sketchybar --add item yabai left                   \
           --set yabai "${yabai[@]}"               \
           --set yabai "${bracket_defaults[@]}"    \
           --subscribe yabai space_change          \
                             mouse.scrolled.global \
                             mouse.clicked         \
                             front_app_switched    \
                             space_windows_change  \
                             update_yabai_icon