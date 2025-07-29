#!/usr/bin/env zsh

# open
alias o="open"
alias v="nvim"
alias cc="codium"

# tmux
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

# ssh
alias sshrawdog="ssh ubuntu@18.235.113.176"
alias sshsparta="ssh -X danny@unix.spartaglobal.com -R 52698:localhost:52698"

# file commands
alias hd="hexdump -C"
alias md5sum="md5"
alias sha1sum="shasum"
alias sys_mdls="mdls -name kMDItemContentTypeTree "

# view http traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w — | grep -a -o -E \"Host\: .*|GET \/.*\""

# get files
alias get="curl $HOME/.dotfiles/config/curl/curlrc -O"
alias wget="wget --config=$HOME/.dotfiles/config/wget/wgetrc --no-check-certificate"

# bat
alias cat="bat"
alias -g :h='-h 2>&1 | bat --language=help --style=plain'
alias -g :h='--help 2>&1 | bat --language=help --style=plain'

# dirs
alias ~="cd ~"
alias ..="cd .."

# brew leaves
alias b-leaves="brew leaves | xargs brew desc --eval-all"
alias b-leaves-casks="brew ls --casks | xargs brew desc --eval-all"

# transmission
alias trd="transmission-daemon"
alias tr="transmission-remote --auth stache:open"
alias trw="watch --interval 2 'transmission-remote -n 'stache:open' -l'"
alias tra="tr -a"
alias trl="tr -l"
alias trs="tr -s"

# ls replacement - gls coreutils
alias ls='/opt/homebrew/bin/gls --color=auto --group-directories-first -I .DS_Store -I .Trash -I "Icon'$'\r"'
alias l="ls -AhLg --no-group --time-style=iso"
alias ll="lsd -Al"
alias la="ls -A"

# ls replacement - eza https://github.com/eza-community/eza
ezargs="--icons -I='$(awk '{$1=$1} NF{printf "%s|", $0}' "${DOTFILES}/config/eza/ezaignore" | sed 's/|$//')' --group-directories-first"
alias els="eza -lah $ezargs" # all files and dirs; long format
alias elg="eza -Galh $ezargs" # all files and dirs; long format/grid
alias ela="eza -a $ezargs" # all files and dirs
alias etr="eza -aT $ezargs" # tree listing
alias ell='eza -l --all --show-symlinks | grep "^l"'
alias el.='eza -la --git-ignore --group-directories-first | egrep "^\."'

# grep
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# edit in nvim
alias dotcon="cd $DOTFILES && nvim"

# list global pkgs
alias lsg_npm="npm ls -g --depth 0"
alias lsg_yarn="yarn global list"
alias lsg_pnpm="pnpm ls -g"

# directories
alias dotfiles="cd $HOME/.dotfiles"
alias dl="cd $HOME/Downloads"
alias plugins="cd $HOME/Developer/plugins"
alias repos="cd $HOME/Developer/repos"
alias served="cd $HOME/Developer/served"
alias temp="cd $HOME/Developer/temp"

# reload
alias clear="clear "
alias reload="exec $SHELL -l"
alias src="source $HOME/.zshrc"
alias cl="clear"
alias c="cl && reload && src"

# turn spotlight on/off
alias spotlight_off="sudo mdutil -a -i off"
alias spotlight_on="sudo mdutil -a -i on"

# monitor icloud
alias brctl_monitor="brctl monitor com.apple.CloudDocs | grep %"

# js repl
alias jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Helpers/jsc"

# browsers
alias chrome="open -a /Applications/Google\ Chrome.app"
alias canary="open -a /Applications/Google\ Chrome\ Canary.app"
alias firefox="open -a /Applications/Firefox.app"

# exclude macOS specific files in zip archives
alias zip="zip -x *.DS_Store -x *__MACOSX* -x *.AppleDouble*"

# start screen saver
alias afk="open /System/Library/CoreServices/ScreenSaverEngine.app"

# log off
alias logoff="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# clean hidden files
alias rmds="find . -type f -name '*.DS_Store' -ls -delete"
alias rmnm="find . -type d -name 'node_modules' -ls -delete"
alias rmad="find . -type d -name '.AppleD*' -ls -exec /bin/rm -r {} \;"

# clean up launch services to remove duplicates in the "open with" menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# empty trash on mounted volumes and main HDD, and clear system logs
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash/*; sudo rm -rfv /private/var/log/asl/*.asl"

# reload native apps
alias killfinder="killall Finder"
alias killdock="killall Dock"
alias killmenubar="killall SystemUIServer NotificationCenter"
alias killos="killfinder && killdock && killmenubar"

# show system information
alias displays="system_profiler SPDisplaysDataType"
alias cpu="sysctl -n machdep.cpu.brand_string"
alias ram="top -l 1 -s 0 | grep PhysMem"

# misc
alias hosts="sudo $EDITOR /etc/hosts"
alias quit="exit"
alias speedtest="wget -O /dev/null http://speed.transip.nl/100mb.bin"
alias fkill="ps -e | fzf | awk '{print $1}' | xargs kill"

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
