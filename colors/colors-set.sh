#!/usr/bin/env bash

# exit immediately if a command exits with a non-zero status
set -e

# function to display error messages
error() {
  echo "Error: $1" >&2
  exit 1
}

# ensure a colorscheme profile is provided
if [ -z "$1" ]; then
  error "No colorscheme profile provided"
fi

colors_profile="$1"

# define paths
colorscheme_file="$HOME/.dotfiles/colors/list/$colors_profile"
active_file="$HOME/.dotfiles/colors/active/colors-active.sh"

# check if the colorscheme file exists
if [ ! -f "$colorscheme_file" ]; then
  error "Colorscheme file '$colorscheme_file' does not exist."
fi

# if active-colors.sh doesn't exist, create it
if [ ! -f "$active_file" ]; then
  echo "Active colorscheme file not found. Creating '$active_file'."
  cp "$colorscheme_file" "$active_file"
  UPDATED=true
else
  # compare the new colorscheme with the active one
  if ! diff -q "$active_file" "$colorscheme_file" >/dev/null; then
    UPDATED=true
  else
    UPDATED=false
  fi
fi

generate_ghostty_config() {
  ghostty_conf_file="$HOME/.dotfiles/config/ghostty/themes/theme"

  bat >"$ghostty_conf_file" <<EOF
background = $dots_color16
foreground = $dots_color17

cursor-color = $dots_color18

# black
palette = 0=$dots_color00
palette = 8=$dots_color08
# red
palette = 1=$dots_color01
palette = 9=$dots_color09
# green
palette = 2=$dots_color02
palette = 10=$dots_color10
# yellow
palette = 3=$dots_color03
palette = 11=$dots_color11
# blue
palette = 4=$dots_color04
palette = 12=$dots_color12
# purple
palette = 5=$dots_color05
palette = 13=$dots_color13
# aqua
palette = 6=$dots_color06
palette = 14=$dots_color14
# white
palette = 7=$dots_color07
palette = 15=$dots_color15
EOF

  echo "Ghostty configuration updated at '$ghostty_conf_file'."
}

generate_btop_config() {
  btop_conf_file="$HOME/.dotfiles/config/btop/themes/theme.theme"

  bat >"$btop_conf_file" <<EOF
# Main background, empty for terminal default, need to be empty if you want transparent background
theme[main_bg]=""

# Main text color
theme[main_fg]="$dots_color14"

# Title color for boxes
theme[title]="$dots_color14"

# Highlight color for keyboard shortcuts
theme[hi_fg]="$dots_color02"

# Background color of selected item in processes box
theme[selected_bg]="$dots_color04"

# Foreground color of selected item in processes box
theme[selected_fg]="$dots_color14"

# Color of inactive/disabled text
theme[inactive_fg]="$dots_color09"

# Color of text appearing on top of graphs, i.e uptime and current network graph scaling
theme[graph_text]="$dots_color14"

# Background color of the percentage meters
theme[meter_bg]="$dots_color17"

# Misc colors for processes box including mini cpu graphs, details memory graph and details status text
theme[proc_misc]="$dots_color01"

# Cpu box outline color
theme[cpu_box]="$dots_color04"

# Memory/disks box outline color
theme[mem_box]="$dots_color02"

# Net up/down box outline color
theme[net_box]="$dots_color03"

# Processes box outline color
theme[proc_box]="$dots_color05"

# Box divider line and small boxes line color
theme[div_line]="$dots_color17"

# Temperature graph colors
theme[temp_start]="$dots_color01"
theme[temp_mid]="$dots_color16"
theme[temp_end]="$dots_color06"

# CPU graph colors
theme[cpu_start]="$dots_color01"
theme[cpu_mid]="$dots_color05"
theme[cpu_end]="$dots_color02"

# Mem/Disk free meter
theme[free_start]="$dots_color18"
theme[free_mid]="$dots_color16"
theme[free_end]="$dots_color06"

# Mem/Disk cached meter
theme[cached_start]="$dots_color03"
theme[cached_mid]="$dots_color05"
theme[cached_end]="$dots_color08"

# Mem/Disk available meter
theme[available_start]="$dots_color21"
theme[available_mid]="$dots_color01"
theme[available_end]="$dots_color04"

# Mem/Disk used meter
theme[used_start]="$dots_color19"
theme[used_mid]="$dots_color05"
theme[used_end]="$dots_color02"

# Download graph colors
theme[download_start]="$dots_color01"
theme[download_mid]="$dots_color02"
theme[download_end]="$dots_color05"

# Upload graph colors
theme[upload_start]="$dots_color08"
theme[upload_mid]="$dots_color16"
theme[upload_end]="$dots_color06"

# Process box color gradient for threads, mem and cpu usage
theme[process_start]="$dots_color03"
theme[process_mid]="$dots_color02"
theme[process_end]="$dots_color06"
EOF

  echo "Btop configuration updated at '$btop_conf_file'."
}

generate_starship_config() {
  # define the path to the active-config.toml
  starship_conf_file="$HOME/.dotfiles/config/starship/config.toml"

  # generate the Starship configuration file
  bat >"$starship_conf_file" <<EOF
# This will show the time on a 2nd line
# Add a "\\" at the end of an item, if you want the next item to show on the same line
format = """
\$username\\
\$hostname\\
\$time\\
\$all\\
\$directory
\$kubernetes
\$character
"""

[character]
success_symbol = '[❯❯❯❯](${dots_color02} bold)'
error_symbol = '[XXXX](${dots_color11} bold)'
vicmd_symbol = '[❮❮❮❮](${dots_color04} bold)'

[battery]
disabled = true

[gcloud]
disabled = true

[time]
style = '${dots_color04} bold'
disabled = false
format = '[\[\$time\]](\$style) '
# https://docs.rs/chrono/0.4.7/chrono/format/strftime/index.html
# %T	00:34:60	Hour-minute-second format. Same to %H:%M:%S.
# time_format = '%y/%m/%d %T'
time_format = '%y/%m/%d'

# For this to show up correctly, you need to have cluster access
# So your ~/.kube/config needs to be configured on the local machine
[kubernetes]
disabled = false
# context = user@cluster
# format = '[\$user@\$cluster \(\$namespace\)](${dots_color05}) '
# format = '[\$cluster \(\$namespace\)](${dots_color05}) '
# Apply separate colors for cluster and namespace
format = '[\$cluster](${dots_color05} bold) [\$namespace](${dots_color02} bold) '
# format = 'on [⛵ (\$user on )(\$cluster in )\$context \(\$namespace\)](dimmed green) '
# Only dirs that have this file inside will show the kubernetes prompt
# detect_files = ['900-detectkubernetes.sh']
# detect_env_vars = ['STAR_USE_KUBE']
# contexts = [
#   { context_pattern = "dev.local.cluster.k8s", style = "green", symbol = "💔 " },
# ]

[username]
style_user = '${dots_color04} bold'
style_root = 'white bold'
format = '[\$user](\$style).@.'
show_always = true

[hostname]
ssh_only = true
format = '(white bold)[\$hostname](${dots_color02} bold)'

[directory]
style = '${dots_color03} bold'
truncation_length = 0
truncate_to_repo = false

[ruby]
detect_variables = []
detect_files = ['Gemfile', '.ruby-version']
EOF

  echo "Starship configuration updated at '$starship_conf_file'."
}

# if there's an update, replace the active colorscheme and perform necessary actions
if [ "$UPDATED" = true ]; then
  echo "Updating active colorscheme to '$colors_profile'."

  # replace the contents of active-colors.sh
  cp "$colorscheme_file" "$active_file"

  # source the active colorscheme to load variables
  source "$active_file"

  # set the tmux colors
  tmux source-file ~/.tmux.conf
  echo "Tmux colors set and tmux configuration reloaded."

  # generate starship config file
  generate_starship_config

  # generate ghostty config file
  generate_ghostty_config

  # generate btop config file
  generate_btop_config

fi
