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
bindkey -s ^o "tmux attach -t main_session\n"

# bat
alias cat="bat"
alias -g :h='-h 2>&1 | bat --language=help --style=plain'
alias -g :h='--help 2>&1 | bat --language=help --style=plain'

# dirs
alias ~="cd ~"
alias ..="cd .."

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

# brew leaves
alias b-leaves="brew leaves | xargs brew desc --eval-all"
alias b-leaves-casks="brew ls --casks | xargs brew desc --eval-all"

# transmission
alias trd="transmission-daemon"
alias tr="transmission-remote --auth stache:open"
alias tra="tr -a"
alias trl="tr -l"
alias trs="tr -s"

# gls coreutils
alias ls='/opt/homebrew/bin/gls --color=auto --group-directories-first -I .DS_Store -I .Trash -I "Icon'$'\r"'
alias l="ls -AhLg --no-group --time-style=iso"
alias ll="lsd -Al"
alias la="ls -A"

# grep
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# edit in nvim
alias dotconf="cd $DOTFILES && nvim"
alias nvconf="cd $DOTFILES/config/nvim && nvim"

# list global pkgs
alias lsg_npm="npm ls -g --depth 0"
alias lsg_yarn="yarn global list"
alias lsg_pnpm="pnpm ls -g"

# clean hidden files
alias rmds="find . -type f -name '*.DS_Store' -ls -delete"
alias rmnm="find . -type d -name 'node_modules' -ls -delete"

# directories
alias dotfiles="cd $HOME/.dotfiles"
alias dl="cd $HOME/Downloads"
alias plugins="cd $HOME/Developer/plugins"
alias repos="cd $HOME/Developer/repos"
alias served="cd $HOME/Developer/served"
alias temp="cd $HOME/Developer/temp"

# reload
alias reload="exec $SHELL -l"
alias src="source $HOME/.zshrc"
alias c="reload && src"

# turn spotlight on/off
alias spotlight_off="sudo mdutil -a -i off"
alias spotlight_on="sudo mdutil -a -i on"

# monitor icloud
alias brctl_monitor="brctl monitor com.apple.CloudDocs | grep %"

# js repl
alias jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Helpers/jsc"

# clean up LaunchServices to remove duplicates in the "open with" menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

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

# pretty paths
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
