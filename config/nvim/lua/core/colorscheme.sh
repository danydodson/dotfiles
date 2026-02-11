#!/usr/bin/env bash

# These files have to be executable

# Lighter markdown headings
# 4 colors to the right for these ligher headings
# https://www.color-hex.com/color/987afb
#
# Given that color A (#987afb) becomes color B (#5b4996) when darkened 4 steps
# to the right, apply the same darkening ratio/pattern to calculate what color
# C (#37f499) becomes when darkened 4 steps to the right.
#
# Markdown heading 1 - color04
spatch_color18=#494949
# Markdown heading 2 - color02
spatch_color19=#2a2a2a
# Markdown heading 3 - color03
spatch_color20=#1a1a1a
# Markdown heading 4 - color01
spatch_color21=#7f6900
# Markdown heading 5 - color05
spatch_color22=#5b4c00
# Markdown heading 6 - color08
spatch_color23=#999999
# Markdown heading foreground
# usually set to color10 which is the terminal background
spatch_color26=#000000

spatch_color04=#b2b2b2
spatch_color02=#939393
spatch_color03=#d1d1d1
spatch_color01=#d4b000
spatch_color05=#997f00
spatch_color08=#ffffff
spatch_color06=#027085

# Colors to the right from https://www.colorhexa.com
# Terminal and neovim background
spatch_color10=#000000
# Lualine across, 1 color to the right of background
spatch_color17=#0a0a0a
# Markdown codeblock, 2 to the right of background
spatch_color07=#141414
# Background of inactive tmux pane, 3 to the right of background
spatch_color25=#1f1f1f
# line across cursor, 5 to the right of background
spatch_color13=#333333
# Tmux inactive windows, 7 colors to the right of background
spatch_color15=#474747

# Comments
spatch_color09=#5c5c5c
# Underline spellbad
spatch_color11=#ff7676
# Underline spellcap
spatch_color12=#b7a54c
# Cursor and tmux windows text
spatch_color14=#ffffff
# Selected text
spatch_color16=#0390ac
# Cursor color
spatch_color24=#04d1f9

# Wallpaper for this colorscheme
wallpaper="$HOME/Pictures/Walls/streets.jpeg"
