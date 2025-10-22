#!/usr/bin/env zsh

# open
alias o="open"
alias v="nvim"
alias c="codium"

# reload
alias cc="clear && exec $SHELL -l && source $HOME/.zshrc"

# curl
alias get="curl $HOME/.dotfiles/config/curl/curlrc -O"

# wget
alias wget="wget --config=$HOME/.dotfiles/config/wget/wgetrc --no-check-certificate"

# bat
alias cat="bat"
alias -g :h='-h 2>&1 | bat --language=help --style=plain'
alias -g :h='--help 2>&1 | bat --language=help --style=plain'

# brew leaves
alias bl="brew leaves | xargs brew desc --eval-all"
alias blc="brew ls --casks | xargs brew desc --eval-all"

# ssh
alias sshrawdog="ssh ubuntu@18.235.113.176"
alias sshsparta="ssh -X danny@unix.spartaglobal.com -R 52698:localhost:52698"

# capture http requests
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"

# capture http traffic
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w — | grep -a -o -E \"Host\: .*|GET \/.*\""

# transmission
alias trd="transmission-daemon"
alias tr="transmission-remote --auth stache:open"
alias trw="watch --interval 2 'transmission-remote -n 'stache:open' -l'"
alias tra="tr -a"
alias trl="tr -l"
alias trs="tr -s"

# file commands
alias hd="hexdump -C"
alias md5sum="md5"
alias sha1sum="shasum"
alias sys_mdls="mdls -name kMDItemContentTypeTree "

# list global pkgs
alias lsg_npm="npm ls -g --depth 0"

# tmux
alias tmux="tmux -f ~/.config/tmux/tmux.conf"
alias tn="tmux new"
alias tl="tmux ls"
alias ta="tmux attach"
alias tk="tmux kill-session"
alias td="tmux detach"
bindkey -s ^p "tms\n"
bindkey -s ^w "tmux new\n"
bindkey -s ^o "tmux attach -t working\n"
bindkey '^s' vicmd '^s' sesh-sessions
bindkey '^s' viins '^s' sesh-sessions

# js repl
alias jscl="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Helpers/jsc"

# browsers
alias brave="open -a 'Brave Browser.app'"
alias twilight="open -a Twilight.app"

# clean hidden files
alias rmds="find . -type f -name '*.DS_Store' -ls -delete"
alias rmnm="find . -type d -name 'node_modules' -ls -delete"
alias rmad="find . -type d -name '.AppleD*' -ls -exec /bin/rm -r {} \;"

# start screen saver
alias afk="open /System/Library/CoreServices/ScreenSaverEngine.app"

# log off
alias logoff="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# show system information
alias displays="system_profiler SPDisplaysDataType"
alias cpu="sysctl -n machdep.cpu.brand_string"
alias ram="top -l 1 -s 0 | grep PhysMem"

# misc
alias hosts="sudo nvim /etc/hosts"
alias quit="exit"
alias speedtest="wget -O /dev/null http://speed.transip.nl/100mb.bin"
alias fkill="ps -e | fzf | awk '{print $1}' | xargs kill"
alias brcmon="brctl monitor com.apple.CloudDocs | grep %"

# reload ui
alias killmenubar="killall SystemUIServer NotificationCenter"
alias killos="killfinder && killdock && killmenubar"

# spotlight on/off
alias spotlight_off="sudo mdutil -a -i off"
alias spotlight_on="sudo mdutil -a -i on"

# ls
alias ls='/opt/homebrew/bin/gls --color=auto --group-directories-first -I .DS_Store -I .Trash -I "Icon'$'\r"'
alias l="ls -AhLg --no-group --time-style=iso"
alias ll="lsd -Al"
alias la="ls -A"

# dirs
alias ~="cd ~"
alias ..="cd .."
alias ....="cd ../../"

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
