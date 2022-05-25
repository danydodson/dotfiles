#!/bin/bash

# Trigger new builds for repos deployed on github pages

# Load GITHUB_TOKEN from .env
export "$(grep -E -v '^#' "$DOTFILES/.env" | xargs)"

# Declare repositories to be triggered
declare -a _repositories=("danydodson.github.io")

# For every declared repository
for repo in "${_repositories[@]}"; do
  # Trigger new build and log on success
  curl --silent --output /dev/null --show-error -u danydodson:"$GITHUB_TOKEN" -X POST https://api.github.com/repos/danydodson/"$repo"/pages/builds
done
