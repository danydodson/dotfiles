#!/usr/bin/env bash

unalias -a

# ============================================================================
# These may be re-aliased later (e.g. rm=trash from trash-cli node module)
# ============================================================================

alias cp="nocorrect cp"
alias mv="nocorrect mv"
alias rm="nocorrect rm"
alias mkdir="nocorrect mkdir"

#######################################################################
# safeguarding
# @see {@link https://github.com/sindresorhus/guides/blob/master/how-not-to-rm-yourself.md#safeguard-rm}
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
alias cdd='cd -- "${DOTFILES}"'
alias dirs='dirs -v'
alias src=". ~/.zshrc"
alias fpath='echo -e ${FPATH//:/\\n}'
alias path='echo -e ${PATH//:/\\n}'

#######################################################################
# cat (prefer bat)
#######################################################################

alias crm='bat --plain README.md'
alias cpj='bat --plain package.json'
alias pyg='pygmentize -O style=rrt -f console256 -g'

#######################################################################
# node / JS
#######################################################################

alias gulp='npx gulp'
alias grunt='npx grunt'
alias n='npm'
alias ni='n install'
alias nomod='rm -rf ./node_modules'
alias likereallynomod='find . -type d -iname node_modules -exec rm \-rf {} \;'
alias nr='n run'
alias ns='n start'
alias yarn='yarn --use-yarnrc $HOME/.config/yarn/yarnrc'
alias y='yarn'
alias yi='yarn install'
alias yr='yarn run'
alias yt='yarn test'

#######################################################################
# python
#######################################################################

alias pea='pyenv activate'
alias ped='pyenv deactivate'
alias pss='pyenv shell system'

#######################################################################
# Homebrew
#######################################################################

alias b='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias brew='b'

alias bi='b install'
alias bs='b search'
alias blfn='b ls --full-name'

alias brc='b cask'

alias bsvc='b services'
alias bsvr='b services restart'

alias bwhy='b uses --installed --recursive'

alias cask='brc'
alias ci='brc install'
alias caskrm="brew uninstall --cask --force"

#######################################################################
# Apps
#######################################################################

alias chrome='open -a "Google Chrome.app"'
alias slack='open -a Slack.app'
alias ios='open -a Simulator.app'

#######################################################################
# spotlight
#######################################################################

alias spotoff='sudo mdutil -a -i off'
alias spoton='sudo mdutil -a -i on'

#######################################################################
# ssh
#######################################################################

# @see {@link https://blog.g3rt.nl/upgrade-your-ssh-keys.html}
# Keep this up to date with latest security best practices
alias sshkeygen='ssh-keygen -o -a 100 -t ed25519'

#######################################################################
# get public key
#######################################################################

alias pubkey='more ~/.ssh/id_rsa.pub | pbcopy | echo "=> Public key copied to pasteboard."'

#######################################################################
# sudo ops
#######################################################################

alias root='sudo -s'
alias se='sudo -e'

#######################################################################
# tmux
#######################################################################

alias tmux='tmux -f "${DOTFILES}/tmux/tmux.conf"'
alias ta='tmux attach'

#######################################################################
# rest of bins
#######################################################################

alias brokensymlinks='find . -type l ! -exec test -e {} \; -print'
alias curl='curl --config "${DOTFILES}/config/curl/dot.curlrc"'
alias df='df -h'
alias flush='sudo killall -HUP mDNSResponder'
alias gpgreload='gpg-connect-agent reloadagent /bye'
alias ln='ln -v'
alias o='dko-open'
alias r="ranger"
alias today='date +%Y-%m-%d'
alias tpr='tput reset' # really clear the scrollback
alias u='dot'
alias uuid='uuidgen'
alias wget='wget --no-check-certificate --hsts-file="${XDG_DATA_HOME}/wget/.wget-hsts"'
alias xit='exit' # dammit

#######################################################################
# Misc
#######################################################################

# sudo since we run nginx on port 80 so needs admin
alias rnginx='sudo brew services restart nginx'

# electron apps can't focus if started using Electron symlink
alias elec='/Applications/Electron.app/Contents/MacOS/Electron'

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
  __classify='-F'   # switched from --classify for old bash support
  __colorized='--color=auto'
  __groupdirs='--group-directories-first'
  __literal=''
  __long='-l'
  __single_column='-1'
  alias r="ranger"
  alias uuid='uuidgen'
  __timestyle=''
  #__almost_all='-A'
  #__classify='-F'
  __colorized='-G'
  __groupdirs=''

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
