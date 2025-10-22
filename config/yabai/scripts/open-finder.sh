#!/usr/bin/env bash

# Checks if Finder is open on any space. If not, it opens a new Finder window in the current space

sharpener -r 4;

finder_app="Finder"
finder_space_id=$(yabai -m query --windows | jq -r 'map(select(.app == "Finder")) | .[0].space')
finder_window_id=$(yabai -m query --windows | jq -r --arg finder_app "$finder_app" '.[] | select(.app == $finder_app) | .id')

current_space_id=$(yabai -m query --spaces index --space | jq -r '.index')

if [[ $finder_space_id =~ ^[0-9]+$ ]]; then
	yabai -m space --focus $finder_space_id
	yabai -m window --focus $finder_window_id
else

if [[ $finder_space_id = null ]]; then
		open -a Finder
	fi
fi
