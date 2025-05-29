#!/usr/bin/env zsh

alias sudo="sudo "

# file managers
alias o="open"
alias oo="open ."
alias rr="ranger"

alias cl="clear"
alias or="omz reload"
alias c="cl && or"

# get files
alias get="curl -O -L --silent"
alias wget="wget --no-check-certificate"

# editors
alias e="$EDITOR"
alias cc="codium"
alias v="nvim"
alias nv_normal="NVIM_APPNAME=nvim-normal nvim"
alias nv_ide="NVIM_APPNAME=nv-ide nvim"

# shortcuts
alias dotconf="cd $DOTFILES && nvim"
alias nvconf="cd $HOME/.config/nvim && nvim"

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

# pkg managers
alias lsg_npm="npm ls -g --depth 0"
alias lsg_yarn="yarn global list"
alias lsg_pnpm="pnpm ls -g"

# huggingface
alias hf="huggingface-cli"

# brew bundle
alias bbinstall="brew bundle install --file=$HOME/.dotfiles/macos/brewfile"
alias bbcleanup="brew bundle cleanup --file=$HOME/.dotfiles/macos/brewfile"
alias bbcheck="brew bundle check --file=$HOME/.dotfiles/macos/brewfile"
alias bbdump="brew bundle dump --file=$HOME/.dotfiles/macos/brewfile --force"

# postgresql
alias psql_status="brew services info postgresql"
alias psql_start="brew services start postgresql"
alias psql_restart="brew services restart postgresql"
alias psql_stop="brew services stop postgresql"

# brew leaves
alias blea="brew leaves | xargs brew desc --eval-all"
alias bleac="brew ls --casks | xargs brew desc --eval-all"

# python
alias py_clean='find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rvf'
alias activate='source .venv/bin/activate'
alias venv='PIP_REQUIRE_VIRTUALENV=false python3 -m pip install --upgrade --user pip virtualenv && python3 -m virtualenv .venv && source .venv/bin/activate && python3 -m pip install --upgrade pip && which pip && pip list && pip --version && python3 --version'
alias pip_purge='pip list --format freeze | xargs pip uninstall -y'
alias pip_install_reqs='ls requirements*.txt | xargs -n 1 pip install -r'

# transmission
alias trc='transmission-cli'
alias trd='transmission-daemon'
alias tr='transmission-remote'
alias tra='transmission-remote -a'
alias trl='transmission-remote -l'

# fastfetch
alias ff="fastfetch"

# ollama
alias ai_install="docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama"
alias ai_start="docker start ollama"
alias ai_stop="docker stop ollama"
alias ai="docker exec -it ollama ollama run mistral:latest"
alias ai_code="docker exec -it ollama ollama run mistral:ruby-mentor"
alias ai_ls="docker exec -it ollama ollama ls"
alias ai_rm="docker exec -it ollama ollama rm"

# gls
alias ls='/opt/homebrew/bin/gls --color=auto --human-readable --group-directories-first -I .DS_Store -I .Trash -I "Icon'$'\r"'
alias l="ls -gol"
alias ll="ls -AlgoL"
alias la="ls -Algo"

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

# js core repl
jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Helpers/jsc"
[ -e "${jscbin}" ] && alias jsc="${jscbin}"
unset jscbin

# launch macos apps
alias ios="open -a Simulator.app"
alias xcode="open -a Xcode.app"
alias mon_icloud="brctl monitor com.apple.CloudDocs | grep %"
alias chrome-dev="open -a 'Brave Browser' --args --remote-debugging-port=9229"

# scutil shortcuts
alias sc_computername="scutil --get ComputerName"
alias sc_localhostname="scutil --get LocalHostName"
alias sc_hostname="scutil --get HostName"
alias sc_dns="scutil --dns"
alias sc_proxy="scutil --proxy"
alias sc_net_info="scutil --nwi"

# sysctl shortcuts
alias sys_cpu="sysctl -n machdep.cpu.brand_string"

# osx"s launchctl
alias launch_list="launchctl list "
alias launch_load="launchctl load "
alias launch_unload="launchctl unload "
alias launch_getenv="launchctl getenv "
alias launch_start="launchctl start "
alias launch_stop="launchctl stop "

# list installed packages
alias sys_pkg_list="pkgutil --pkgs"

# osx"s launch services
alias lsregister="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister"

# get kMDItemContentTypeTree metadata for file
alias sys_uti_file="mdls -name kMDItemContentTypeTree "

# spotlight on/off
alias spotlight_off="sudo mdutil -a -i off"
alias spotlight_on="sudo mdutil -a -i on"

# directories
[ -d $HOME/Downloads ] && alias dl="cd $HOME/Downloads"
[ -d $HOME/.dotfiles ] && alias dots="cd $HOME/.dotfiles"
[ -d $HOME/.config/nvim ] && alias nvims="cd $HOME/.config/nvim"
[ -d $HOME/Developer ] && alias dev="cd $HOME/Developer"
[ -d $HOME/Developer/boiler ] && alias boil="cd $HOME/Developer/boiler"
[ -d $HOME/Developer/plugins ] && alias plug="cd $HOME/Developer/plugins"
[ -d $HOME/Developer/practice ] && alias prac="cd $HOME/Developer/practice"
[ -d $HOME/Developer/courses ] && alias course="cd $HOME/Developer/courses"
[ -d $HOME/Developer/repos ] && alias repo="cd $HOME/Developer/repos"
[ -d $HOME/Developer/security ] && alias sec="cd $HOME/Developer/security"
[ -d $HOME/Developer/served ] && alias ser="cd $HOME/Developer/served"
[ -d $HOME/Developer/temp ] && alias temp="cd $HOME/Developer/temp"

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
