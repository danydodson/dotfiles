#!/usr/bin/env bash

unalias -a

#######################################################################
# These may be re-aliased later (e.g. rm=trash from trash-cli node module)
#######################################################################

alias cp="nocorrect cp"
alias mv="nocorrect mv"
alias rm="nocorrect rm"
alias mkdir="nocorrect mkdir"

#######################################################################
# https://github.com/sindresorhus/guides/blob/master/how-not-to-rm-yourself.md#safeguard-rm
#######################################################################

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

#######################################################################
# paths and dirs
#######################################################################

alias ..='cd -- ..'
alias ....='cd -- ../..'
alias cd-='cd -- -'
alias cd..='cd -- ..'
alias dirs='dirs -v'
alias src='. ~/.zshrc'
alias fpath='echo -e ${FPATH//:/\\n}'
alias path='echo -e ${PATH//:/\\n}'

#######################################################################
# cat (prefer bat)
#######################################################################

alias brm='bat --plain readme.md'
alias bpj='bat --plain package.json'
alias pyg='pygmentize -O style=rrt -f console256 -g'

#######################################################################
# node / Yarn
#######################################################################

alias y='yarn'
alias yi='y install'
alias yb='y build'
alias ys='y start'
alias yd='y dev'
alias yu='y upgrade-interactive'
alias n='npm'
alias ni='n install'
alias nr='n run'
alias ns='n start'
alias nrm='n uninstall'
alias nrmg='n uninstall -g'
alias nomod='rm -rf ./node_modules'
alias likereallynomod='find . -type d -iname node_modules -exec rm \-rf {} \;'
alias gulp='npx gulp'
alias grunt='npx grunt'

#######################################################################
# python
#######################################################################

alias notebook='PYDEVD_DISABLE_FILE_VALIDATION=1 jupyter notebook'
alias pea='pyenv activate'
alias ped='pyenv deactivate'
alias pss='pyenv shell system'

#######################################################################
# Homebrew
#######################################################################

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias bi='brew install'
alias bs='brew search'
alias blfn='brew ls --full-name'
alias bsvc='brew services'
alias bsvr='brew services restart'
alias bwhy='brew uses --installed --recursive'
alias brc='brew install --cask'
alias caskrm="brew uninstall --cask"

#######################################################################
# UI Apps
#######################################################################

alias chrome='open -a "Google Chrome.app"'
alias chromedev='open -a "Google Chrome" --args --remote-debugging-port=9229'
alias elec='/Applications/Electron.app/Contents/MacOS/Electron'
alias ios='open -a Simulator.app'

#######################################################################
# CLI Apps
#######################################################################

alias c='code'
alias neo='neofetch'
alias t='tree -fcp --noreport -L 1 -Cia'
alias ytdlp='yt-dlp'

#######################################################################
# Docker
#######################################################################

alias m4b-tool='docker run -it --rm -u $(id -u):$(id -g) -v "$(pwd)":/mnt sandreas/m4b-tool:latest'

#######################################################################
# spotlight
#######################################################################

alias spotoff='sudo mdutil -a -i off'
alias spoton='sudo mdutil -a -i on'

#######################################################################
# ssh
#######################################################################

# link https://blog.g3rt.nl/upgrade-your-ssh-keys.html
alias sshkeygen='ssh-keygen -o -a 100 -t ed25519'

#######################################################################
# get public key
#######################################################################

alias pubkey='more ~/.config/ssh/id_rsa.pub | pbcopy | echo "=> Public key copied to pasteboard."'

#######################################################################
# sudo ops
#######################################################################

alias se='sudo -e'
alias root='sudo -s'

#######################################################################
# tmux
#######################################################################

alias ta='tmux attach'
alias tmux='tmux -f "${DOTFILES}/tmux/tmux.conf"'

#######################################################################
# rest of bins
#######################################################################

alias df='df -h'
alias ln='ln -v'
alias xit='exit' # dammit
alias today='date +%Y-%m-%d'
alias r="ranger"
alias tpr='tput reset'
alias uuid='uuidgen'
alias curl='curl --config "${DOTFILES}/config/curl/dot.curlrc"'
# alias wget='wget --no-check-certificate --hsts-file="${XDG_CONFIG_HOME}/wget/wget-hsts"'
alias brokensymlinks='find . -type l ! -exec test -e {} \; -print'

#######################################################################
# Misc
#######################################################################

# sudo since we run nginx on port 80 so needs admin
alias rnginx='sudo brew services restart nginx'

# Audio control - http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"

#######################################################################
# xcode
#######################################################################

alias cuios='XCODE_XCCONFIG_FILE="${PWD}/xcconfigs/swift31.xcconfig" carthage update --platform iOS'
alias deletederived='rm -rf ~/Library/Developer/Xcode/DerivedData/*'
alias xcimg='xcrun simctl addmedia booted'

#######################################################################

__alias_ls() {
  __almost_all='-A' # switched from --almost-all for old bash support
  __classify='-F' # switched from --classify for old bash support
  __colorized='--color=auto' # or use __colorized='-G'
  __groupdirs='--group-directories-first'
  __literal=''
  __long='-l'
  __single_column='-1'
  __timestyle=''
  alias r="ranger"
  alias uuid='uuidgen'

  # shellcheck disable=SC2139
  alias ls="ls $__colorized $__literal $__classify $__groupdirs $__timestyle"
  # shellcheck disable=SC2139
  alias la="ls $__almost_all"
  # shellcheck disable=SC2139
  alias l="ls $__single_column $__almost_all"
  # shellcheck disable=SC2139
  alias ll="l $__long"
  # shit
  alias kk='ll'

  unset __almost_all __classify __colorized __groupdirs \
    __literal __long __single_column __timestyle
}

__alias_ls
