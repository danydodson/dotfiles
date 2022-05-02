#!/bin/bash

# Install selected brew packages
# > Select files with <Tab>
# > Confirm with <Enter>

selected=$(brew search | fzf -m)

if [[ $selected ]]; then
  for brew in $selected; do
    brew install "$brew"
  done
fi
