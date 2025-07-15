#!/usr/bin/env bash

# Filename: ~/github/dotfiles-latest/colorscheme/list/linkarzu-colors.sh
# ~/github/dotfiles-latest/colorscheme/list/linkarzu-colors.sh

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
linkarzu_color18=#2d244b
# Markdown heading 2 - color02
linkarzu_color19=#10492d
# Markdown heading 3 - color03
linkarzu_color20=#013e4a
# Markdown heading 4 - color01
linkarzu_color21=#4b314c
# Markdown heading 5 - color05
linkarzu_color22=#334800
# Markdown heading 6 - color08
linkarzu_color23=#264361
# Markdown heading foreground
# usually set to color10 which is the terminal background
linkarzu_color26=#0D1116

linkarzu_color04=#987afb
linkarzu_color02=#37f499
linkarzu_color03=#04d1f9
linkarzu_color01=#fca6ff
linkarzu_color05=#acf200
linkarzu_color08=#5fa9f4
linkarzu_color06=#1682ef

# Colors to the right from https://www.colorhexa.com
# Terminal and neovim background
linkarzu_color10=#0D1116
# Lualine across, 1 color to the right of background
linkarzu_color17=#141b22
# Markdown codeblock, 2 to the right of background
linkarzu_color07=#141b22
# Background of inactive tmux pane, 3 to the right of background
linkarzu_color25=#232e3b
# line across cursor, 5 to the right of background
linkarzu_color13=#232e3b
# Tmux inactive windows, 7 colors to the right of background
linkarzu_color15=#013e4a

# Comments
linkarzu_color09=#b7bfce
# Underline spellbad
linkarzu_color11=#f16c75
# Underline spellcap
linkarzu_color12=#f1fc79
# Cursor and tmux windows text
linkarzu_color14=#ffffff
# Selected text
linkarzu_color16=#e9b3fd
# Cursor color
linkarzu_color24=#f94dff

# Wallpaper for this colorscheme
wallpaper="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Images/wallpapers/official/skyrim-dragon-4.webp"
