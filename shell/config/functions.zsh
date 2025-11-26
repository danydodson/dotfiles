#!/usr/bin/env zsh

# Cheat sheets
# >
cheats() {
    local cheats=("$DOTFILES/docs/cheats/"*.md)
    local choice
    choice=$(printf "%s\n" "${cheats[@]}" | fzf --prompt="Select a cheat sheet: ")
    if [ -n "$choice" ]; then
        bat --language=mdown "$choice"
    else
        echo "No cheat sheet selected."
    fi
}

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

# Fix Zsh Behavior
# >
h() {
    if [ -z "$*" ]; then
        history 1
    else
        history 1 | egrep "$@"
    fi
}

# Create and change into a new directory
# >
mkcd() {
  mkdir -p $@ && cd ${@:$#}
}

# Get the Bundle ID of a macOS app
# > bundleid [appname]
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

# Open editor with ctrl+E
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

# Use ctrl+s to d isplay a sesh sessions
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
