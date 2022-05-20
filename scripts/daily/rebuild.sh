#!/bin/bash

# Trigger new builds for repositories deployed on Github Pages.

# Log Helpers
__info() { printf '\033[0;34m[INFO] \033[0;34m%s\033[0;m\n' "$1"; }
__ok() { printf '\033[0;33m[OK] \033[0;36m%s\033[0;m\n' "$1"; }

# Load GITHUB_TOKEN from .env
export "$(grep -E -v '^#' "$HOME/Developer/Dotfiles/.a.env" | xargs)"

# Declare repositories, where new build should be triggered
declare -a _repositories=("danydodson.github.io")

# For every declared repository
for repo in "${_repositories[@]}"; do
  # Trigger new build and log on success
  curl --silent --output /dev/null --show-error -u danydodson:"$GITHUB_TOKEN" -X POST https://api.github.com/repos/danydodson/"$repo"/pages/builds && __ok "triggered new build of $repo"
done
