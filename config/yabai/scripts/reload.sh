#!/bin/bash

SID=$(yabai -m query --spaces index --space | jq -r '.index')
# shellcheck disable=SC1090
source ~/.dotfiles/config.symlink/yabai/yabairc
yabai -m space --focus "$SID"