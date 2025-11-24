#!/bin/bash

# Checks if Finder is open on any space. If not, it opens a new Finder window in the current space

set -u

app_name="Finder"
app_space=$(yabai -m query --windows | jq -r 'map(select(.app == "Finder")) | .[0].space')
app_window=$(yabai -m query --windows | jq -r --arg app "$app_name" '.[] | select(.app == $app) | .id')

if [[ $app_space =~ ^[0-9]+$ ]]; then
	yabai -m space --focus $app_space
	yabai -m window --focus $app_window
else
	if [[ $app_space = null ]]; then
		open -a Finder
	fi
fi
