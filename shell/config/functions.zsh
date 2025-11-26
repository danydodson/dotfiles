#!/usr/bin/env zsh

# # -------------------------------------------------------------------- // NOTEPAD:
# function notepad() {
#     local file="$HOME/Documents/notes/.notes"
#     mkdir -p "$(dirname "$file")"  # Ensure the directory exists
#     [[ -f $file ]] || touch "$file"

#     show_help() {
#         cat << EOF
# Usage: notepad [option] [arguments]
# Options:
#   (no option)       Display all notes
#   -c                Clear all notes
#   -r [number]       Display the last 'number' notes (default 10)
#   -f <YYYY-MM-DD>   Filter notes by specific date
#   -h                Show this help message
#   <note>            Add a new note with a timestamp
# EOF
#     }

#     if (( $# )); then
#         case "$1" in
#             -c)
#                 > "$file"
#                 echo "All notes cleared."
#                 ;;
#             -r)
#                 if [[ -z "$2" || ! "$2" =~ ^[0-9]+$ ]]; then
#                     echo "Invalid or missing argument for -r option. Defaulting to 10."
#                     local recent_count=10
#                 else
#                     local recent_count="$2"
#                 fi
#                 tail -n "$recent_count" "$file"
#                 ;;
#             -f)
#                 if [[ -z "$2" || ! "$2" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
#                     echo "Usage: notepad -f <YYYY-MM-DD>"
#                     return 1
#                 fi
#                 grep "\[$2" "$file" || echo "No notes found for $2."
#                 ;;
#             -h)
#                 show_help
#                 ;;
#             --)
#                 shift
#                 ;;
#             -*)
#                 echo "Invalid option: $1"
#                 show_help
#                 return 1
#                 ;;
#         esac
#     else
#         cat "$file"
#     fi

#     if [[ $# -gt 0 && "$1" != "-"* ]]; then
#         local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
#         printf "[%s] %s\n" "$timestamp" "$*" >> "$file"
#         echo "Note added."
#     fi
# }

# # ---------------------------------------------------------- // RUN_IN_BACKGROUND:
# function 4ever() {
#     if [[ -z "$1" ]]; then
#         echo "Usage: 4everr <command> [arguments] [log_file]"
#         return 1
#     fi

#     local command="$1"
#     shift

#     if command -v "$command" >/dev/null 2>&1; then
#         local log_file="${@: -1}"
#         if [[ -f "$log_file" || "$log_file" == *".log" ]]; then
#             set -- "${@:1:$(($#-1))}"
#         else
#             log_file="/dev/null"
#         fi

#         # Generate a more descriptive log file name if not specified
#         if [[ "$log_file" == "/dev/null" ]]; then
#             log_file="/tmp/${command}_$(date +'%Y%m%d%H%M%S').log"
#         fi

#         # Start the command in the background with nohup and log output
#         nohup "$command" "$@" &> "$log_file" &
#         local pid=$!
#         echo "Command '$command $*' started in the background with PID $pid."
#         echo "Output is being logged to $log_file."

#         # Optionally: Save the PID for later use
#         echo "$pid" > "/tmp/forever_${command}_${pid}.pid"
#     else
#         echo "Command '$command' not found. Not executed."
#         return 1
#     fi
# }

# function whatsnew() {
#     local num_files=${1:-10}
#     echo "Listing the $num_files most recently modified files across the entire system:"

#     # Check if the user has sudo privileges
#     if ! sudo -v &>/dev/null; then
#         echo "Error: You do not have sudo privileges." >&2
#         return 1
#     fi

#     # Using Zsh globbing to find and list the most recently modified files
#     local files
#     files=$(sudo zsh -c "print -rl -- /**/*(.om[1,$num_files])" 2>/dev/null)

#     if [[ -z "$files" ]]; then
#         echo "No recently modified files found."
#     else
#         echo "$files"
#     fi
# }

# Clear back buffer
# >
function reexec_shell() {
    printf '\x1Bc'
    clear
    source "$HOME/.zshrc"
}
alias c='reexec_shell'
zle -N reexec_shell
bindkey -M emacs '^K' reexec_shell
bindkey -M vicmd '^K' reexec_shell
bindkey '^[s' reexec_shell

# Force ctrl+D to close shell
# >
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

# Create and change into a new directory
# > mkcd [dir name]
mkcd() {
  mkdir -p $@ && cd ${@:$#}
}

# Get the Bundle ID of a macOS app
# > bundleid [app name]
#
bundleid() {
  local ID=$( osascript -e 'id of app "'"$1"'"' )
  if [ ! -z $ID ]; then
    echo $ID | tr -d '[:space:]' | pbcopy
    echo "$ID (copied to clipboard)"
  fi
}

# Switch dirs with ctrl+O
# >
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT HUP INT QUIT TERM PWR EXIT'
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'
bindkey -s '^a' '^ubc -lq\n'
bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'
bindkey '^[[P' delete-char

# Open editor with ctrl+e
# >
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete


# Yazi file manager
# >
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# Use ctrl+s to display a sesh sessions
# >
sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(
      sesh list -t -c \
        --icons | fzf-tmux -p 80%,70% \
        --no-sort \
        --ansi \
        --border \
        --prompt '⚡' \
        --header '' \
        --bind 'tab:down,btab:up' \
        --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
        --bind 'ctrl-t:change-prompt(   )+reload(sesh list -t --icons)' \
        --bind 'ctrl-c:change-prompt(⛭  )+reload(sesh list -c --icons)' \
        --bind 'ctrl-z:change-prompt(  )+reload(sesh list -z --icons)' \
        --bind 'ctrl-f:change-prompt(  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
        --preview 'sesh preview {}'
    )
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}
zle -N sesh-sessions
bindkey '^s' vicmd '^s' sesh-sessions
bindkey '^s' viins '^s' sesh-sessions
