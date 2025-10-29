#!/usr/bin/env zsh

# dirs
alias ~="cd ~"
alias ..="cd .."
alias ....="cd ../../"

# open
alias o="open"

# nvim
alias v="nvim"

# codium
alias e="codium"

# reload
alias c="clear && exec $SHELL -l && source $HOME/.zshrc"

# z
alias cd='z'
alias cdd='z -'

# open hosts in nvim
alias hosts="sudo nvim /etc/hosts"

# curl
alias get="curl $HOME/.dotfiles/config/curl/curlrc -O"

# wget
alias wget="wget --config=$HOME/.dotfiles/config/wget/wgetrc --no-check-certificate"

# ssh
alias ssh_rd="ssh ubuntu@18.235.113.176"

# capture http requests
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"

# capture http traffic
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w — | grep -a -o -E \"Host\: .*|GET \/.*\""

# file commands
alias hd="hexdump -C"
alias md5sum="md5"
alias sha1sum="shasum"
alias sys_mdls="mdls -name kMDItemContentTypeTree "

# speedtest
alias speedtest="wget -O /dev/null http://speed.transip.nl/100mb.bin"

# bat
alias cat='bat --wrap=never --paging=never --style=plain --decorations=auto --theme="TwoDark" --color=always'
alias -g :h='-h 2>&1 | bat --language=help --style=plain'
alias -g :h='--help 2>&1 | bat --language=help --style=plain'

# brew
alias bl="brew leaves | xargs brew desc --eval-all"
alias blc="brew ls --casks | xargs brew desc --eval-all"

# kill
alias fkill="ps -e | fzf | awk '{print $1}' | xargs kill"
alias mbkill="killall SystemUIServer NotificationCenter"
alias oskill="killfinder && killdock && killmenubar"

# npm globals
alias lsg_npm="npm ls -g --depth 0"

# tmux
alias tm="tmux -f ~/.config/tmux/tmux.conf"
alias tn="tm new"
alias tl="tm ls"
alias ta="tm attach"
alias tk="tm kill-session"
alias td="tm detach"

# tmux ctrl+p fzf projects
bindkey -s ^p "tms\n"

# tmux ctrl+w new session
bindkey -s ^w "tmux new\n"

# tmux ctrl+o attach to working session
bindkey -s ^o "tmux attach -t working\n"

# tmux ctrl+s opens sesh sessions 
bindkey '^s' vicmd '^s' sesh-sessions
bindkey '^s' viins '^s' sesh-sessions

# js repl
alias jscl="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Helpers/jsc"

# browsers
alias brave="open -a 'Brave Browser.app'"
alias twilight="open -a Twilight.app"

# start screen saver
alias afk="open /System/Library/CoreServices/ScreenSaverEngine.app"

# log off
alias logoff="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# show system information
alias displays="system_profiler SPDisplaysDataType"
alias cpu="sysctl -n machdep.cpu.brand_string"
alias ram="top -l 1 -s 0 | grep PhysMem"

# reload ui
alias killmenubar="killall SystemUIServer NotificationCenter"
alias killos="killfinder && killdock && killmenubar"

# spotlight on/off
alias spotlight_off="sudo mdutil -a -i off"
alias spotlight_on="sudo mdutil -a -i on"

# monitor icloud
alias brcmon="brctl monitor com.apple.CloudDocs | grep %"

# ls
alias ls='/opt/homebrew/bin/gls --color=auto --group-directories-first -I .DS_Store -I .Trash -I "Icon'$'\r"'
alias l="ls -AhLg --no-group --time-style=iso"
alias ll="lsd -Al"
alias la="ls -A"

# transmission-cli
alias trd="transmission-daemon"
alias tr="transmission-remote --auth stache:open"
alias trw="watch --interval 2 'transmission-remote -n 'stache:open' -l'"


# clean hidden files
alias rmds="find . -type f -name '*.DS_Store' -ls -delete"
alias rmnm="find . -type d -name 'node_modules' -ls -delete"
alias rmad="find . -type d -name '.AppleD*' -ls -exec /bin/rm -r {} \;"

# create and cd into directory
mkcd() {
  mkdir -p $@ && cd ${@:$#}
}

# yazi launcher
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# sesh-sessions() {
#   {
#     exec </dev/tty
#     exec <&1
#     local session
#     session=$(
#       sesh list -t -c \
#         --icons | fzf-tmux -p 80%,70% \
#         --no-sort \
#         --ansi \
#         --border \
#         --prompt '⚡' \
#         --header '' \
#         --bind 'tab:down,btab:up' \
#         --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
#         --bind 'ctrl-t:change-prompt(   )+reload(sesh list -t --icons)' \
#         --bind 'ctrl-c:change-prompt(⛭  )+reload(sesh list -c --icons)' \
#         --bind 'ctrl-z:change-prompt(  )+reload(sesh list -z --icons)' \
#         --bind 'ctrl-f:change-prompt(  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
#         --preview 'sesh preview {}'
#     )
#     zle reset-prompt > /dev/null 2>&1 || true
#     [[ -z "$session" ]] && return
#     sesh connect $session
#   }
# }
# zle -N sesh-sessions

paths() {
  local blue="\e[34m"
  local green="\e[32m"
  local yellow="\e[0;93m"
  local red="\e[31m"
  local reset="\e[0m"

  for dir in ${(s.:.)PATH}; do
    if [[ -d "$dir" ]]; then
      echo "${green}✓${reset} ${blue}$dir${reset}"
    else
      echo "${red}✗${reset} $dir"
    fi
  done
}

fpaths() {
  local blue="\e[34m"
  local green="\e[32m"
  local yellow="\e[0;93m"
  local red="\e[31m"
  local reset="\e[0m"

  for dir in ${(s.:.)FPATH}; do
    if [[ -d "$dir" ]]; then
      echo "${green}✓${reset} ${blue}$dir${reset}"
    else
      echo "${red}✗${reset} $dir"
    fi
  done
}

macos_paths() {
  local blue="\e[34m"
  local green="\e[32m"
  local yellow="\e[0;93m"
  local red="\e[31m"
  local reset="\e[0m"

  local macos_path
  macos_path=$(launchctl getenv PATH)

  for dir in ${(s.:.)PATH}; do
    if [[ -d "$dir" ]]; then
      echo "${green}✓${reset} ${blue}$dir${reset}"
    else
      echo "${red}✗${reset} $dir"
    fi
  done
}

manpaths() {
  local blue="\e[34m"
  local green="\e[32m"
  local yellow="\e[0;93m"
  local red="\e[31m"
  local reset="\e[0m"

  for dir in ${(s.:.)MANPATH}; do
    if [[ -d "$dir" ]]; then
      echo "${green}✓${reset} ${blue}$dir${reset}"
    else
      echo "${red}✗${reset} $dir"
    fi
  done
}
