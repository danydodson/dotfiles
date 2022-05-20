#!/bin/bash

# Trigger new builds for repositories deployed on Github Pages.

# Log Helpers
. "$HOME/Developer/Dotfiles/utilities/helpers.sh"
. "$HOME/Developer/Dotfiles/utilities/pretty.bash"

# Load GITHUB_TOKEN from .env
export "$(grep -E -v '^#' "/Users/Dany/Developer/Dotfiles/.env" | xargs)"

# Declare repositories, where new build should be triggered
declare -a _repositories=("danydodson.github.io" "neumorphism")

# For every declared repository
for repo in "${_repositories[@]}"; do
  # Trigger new build and log on success
  curl --silent --output /dev/null --show-error -u danydodson:"$GITHUB_TOKEN" -X POST https://api.github.com/repos/danydodson/"$repo"/pages/builds && __ok "triggered new build of $repo"
done
