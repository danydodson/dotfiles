#!/usr/bin/env zsh

alias sudo="sudo "

# reload
alias cl="clear"
alias or="omz reload"
alias c="cl && or"

# finder
alias o="open"
alias oo="open ."

# editors
alias e="$EDITOR"
alias vv="nvim"
alias cc="codium"

# nvim edit
alias dotsconf="cd $DOTFILES && nvim"
alias nvimconf="cd $HOME/.config/nvim && nvim"

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
alias get="curl -O -L --silent"
alias wget="wget --no-check-certificate --hsts-file=$DOTFILES/config/wget/wget-hsts"

# pkg managers
alias lsg_npm="npm ls -g --depth 0"
alias lsg_yarn="yarn global list"
alias lsg_pnpm="pnpm ls -g"

# huggingface
alias hf="huggingface-cli"

# brew bundle
alias bb="brew bundle --file=$HOME/.dotfiles/macos/brewfile --global --force"

# brew leaves
alias b-leaves="brew leaves | xargs brew desc --eval-all"
alias b-leaves-casks="brew ls --casks | xargs brew desc --eval-all"

# transmission
alias trd='transmission-daemon'
alias tr='transmission-remote'

# fastfetch
alias ff="fastfetch"

# gls coreutils
alias ls='/opt/homebrew/bin/gls --color=auto --group-directories-first -I .DS_Store -I .Trash -I "Icon'$'\r"'
alias l="ls -hLg --no-group --time-style=iso"
alias ll="ls -AhLg --no-group --time-style=iso"

# pretty paths
alias path="printf '%s\n' $path"
alias fpath="printf '%s\n' $fpath"

# clean .DS_Store files
alias rmds="find . -type f -name '*.DS_Store' -ls -delete"

# clean node_modules directories
alias rmnm="find . -type d -name 'node_modules' -ls -delete"

# canonical hex dump
alias hd="hexdump -C"

# macos has no md5sum, so use md5 as a fallback
alias md5sum="md5"

# macos has no sha1sum, so use shasum as a fallback
alias sha1sum="shasum"

# macos apps
alias xcode="open -a Xcode.app"
alias mon_icloud="brctl monitor com.apple.CloudDocs | grep %"

# scutil
alias sc="scutil"

# display cpu info
alias sys_cpu="sysctl -n machdep.cpu.brand_string"

# list installed packages
alias sys_pkgs="pkgutil --pkgs"

# get kMDItemContentTypeTree metadata for a file
alias sys_mdls="mdls -name kMDItemContentTypeTree "

# osxs launch services
alias lsregister="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister"

# turn spotlight on/off
alias spotlight_off="sudo mdutil -a -i off"
alias spotlight_on="sudo mdutil -a -i on"

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

# yazi wrapper
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

function brews() {
  local formulae="$(brew leaves | xargs brew deps --installed --for-each)"
  local casks="$(brew list --cask 2>/dev/null)"

  local blue="$(tput setaf 4)"
  local bold="$(tput bold)"
  local off="$(tput sgr0)"

  echo "${blue}==>${off} ${bold}Formulae${off}"
  echo "${formulae}" | sed "s/^\(.*\):\(.*\)$/\1${blue}\2${off}/"
  echo "\n${blue}==>${off} ${bold}Casks${off}\n${casks}"
}

# js core repl
jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Helpers/jsc"
[ -e "${jscbin}" ] && alias jsc="${jscbin}"
unset jscbin
