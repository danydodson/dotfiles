#!/usr/bin/env zsh

# open
alias o="open"
alias e="$EDITOR"
alias v="nvim"
alias cc="codium"
alias sudo="sudo "

# git
alias gcl="git clone --recursive"
alias gco="git commit -S -m"
alias gpu="git push -u origin main"

# tmux
alias tn="tmux new"
alias tl="tmux ls"
alias ta="tmux attach"
alias tk="tmux kill-session"
alias td="tmux detach"
bindkey -s ^p "tms\n"
bindkey -s ^w "tmux new\n"

# bat
alias cat="bat"
alias -g :b='-h 2>&1 | bat --language=help --style=plain'
alias -g :b='--help 2>&1 | bat --language=help --style=plain'

# get files
alias get="curl $HOME/.dotfiles/config/curl/curlrc -O"
alias wget="wget --config=$HOME/.dotfiles/config/wget/wgetrc --no-check-certificate"

# edit in nvim
alias dotconf="cd $DOTFILES && nvim"
alias nvconf="cd $HOME/.config/nvim && nvim"

# pkg managers
alias lsg_npm="npm ls -g --depth 0"
alias lsg_yarn="yarn global list"
alias lsg_pnpm="pnpm ls -g"

# huggingface
alias hf="huggingface-cli"

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

# clean hidden files
alias rmds="find . -type f -name '*.DS_Store' -ls -delete"
alias rmnm="find . -type d -name 'node_modules' -ls -delete"

# canonical hex dump
alias hd="hexdump -C"

# fallback for md5sum
alias md5sum="md5"

# fallback for sha1sum
alias sha1sum="shasum"

# monitor icloud
alias mon_icloud="brctl monitor com.apple.CloudDocs | grep %"

# show file metadata
alias sys_mdls="mdls -name kMDItemContentTypeTree "

# osxs launch services
alias lsregister="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister"

# spotlight on/off
alias spotlight_off="sudo mdutil -a -i off"
alias spotlight_on="sudo mdutil -a -i on"

# reload
alias c="clear && source $HOME/.zshrc"

# short
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# directories
alias home="cd $HOME"
alias dots="cd $HOME/.dotfiles"
alias dl="cd $HOME/Downloads"
alias games="cd $HOME/Games"
alias nv="cd $HOME/.config/nvim"
alias plugins="cd $HOME/Developer/plugins"
alias practice="cd $HOME/Developer/practice"
alias repos="cd $HOME/Developer/repos"
alias served="cd $HOME/Developer/served"
alias temp="cd $HOME/Developer/temp"

# create and cd into directory
function mkd() {
  mkdir -p $@ && cd ${@:$#}
}

# yazi launcher
function y() {
  local tmp
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd" || exit
  fi
  rm -f -- "$tmp"
}

# pretty paths
function paths() {
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

function fpaths() {
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

# js core repl
jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Helpers/jsc"
[ -e "${jscbin}" ] && alias jsc="${jscbin}"
unset jscbin
