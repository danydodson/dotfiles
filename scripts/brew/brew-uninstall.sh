#!/bin/bash

# Uninstall selected brew packages
# > Select files with <Tab>
# > Confirm with <Enter>

selected=$(brew leaves | fzf -m)

if [[ $selected ]]; then
  for brew in $selected; do
    brew uninstall "$brew"
  done
fi
