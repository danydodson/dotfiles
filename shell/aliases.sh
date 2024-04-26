#!/usr/bin/env bash

# unalias -a

# fixes
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash'

# keep
alias cp="nocorrect cp"
alias mv="nocorrect mv"
alias rm="nocorrect rm"

# aliases
alias dirs='dirs -v'
alias mkdir="nocorrect mkdir"

# sudo
alias se='sudo -e'
alias root='sudo -s'

# nvim -> open nvim
alias nv='nvim'

# b -> brew
alias b='brew'
alias bs='b search'
alias bi='b info'
alias bu='b update && b upgrade && b autoremove && b cleanup --prune=all -s'

# pn -> pnpm
alias pn='pnpm'

# n -> npm
alias n='npm'

# gcp -> github copilot
alias gcp='gh copilot'

# hts -> http-server
alias hts='http-server'

# lvs -> live-server
alias lvs='live-server'
alias lsg-npm='npm ls -g --depth 0'

alias lsg-yarn='yarn global list'

# r -> ranger
alias r='ranger'

# gmo -> git merge origin
alias gmo='git checkout $(git remote show origin | grep "HEAD branch" | cut -d " " -f5) && git pull && git checkout - && git merge $(git remote show origin | grep "HEAD branch" | cut -d " " -f5)'

# grb -> git checkout recent branch
alias grb='git branch --sort=-committerdate | grep -v "$(git branch --show-current)" | fzf --header "Checkout Recent Branch ( $(git branch --show-current))" --preview "git diff {1} --color=always" --pointer="" | xargs git checkout'

# gcw -> git commit "work in progress"
alias gcw='git add . && git commit -m ":sparkles: wip" --no-verify'

# afk ->  open screen saver
alias afk="open -a /System/Library/CoreServices/ScreenSaverEngine.app"

# brm -> pretty print
alias brm='bat --plain readme.md'

# bt -> pretty print
alias bt='bat --style="numbers" --color=always --theme="Tokyo-Night-Enki" --tabs=2 --map-syntax= --paging=never'

# uuid -> generate a uuid
alias uuid='uuidgen'

# top -> system monitor
alias top="sudo htop"

# neo -> system details
alias neo='neofetch'

# ping -> nicer ping
alias ping='prettyping --nolegend'

# rmquar -> removes quarantine properties
alias rmquar='xattr -d com.apple.quarantine'

# ssh-dany-macbook -> dany@macbook
alias sshm1="ssh dany@192.168.0.3"

# sshkeygen -> create a public key
alias sshkeygen='ssh-keygen -o -a 100 -t ed25519'

# pubkey -> copy key to clipboard
alias pubkey='more ~/.config/ssh/id_rsa.pub | pbcopy | echo "=> Public key copied to pasteboard."'

# fpath -> pretty fpath
alias fpath='echo -e ${FPATH//:/\\n}'

# path -> pretty path
alias path='echo -e ${PATH//:/\\n}'

# ytd -> default directory
alias ytd='yt-dlp -o ~/Movies'

# curl -> with configs
alias curl='curl --silent'

# wget -> with configs
alias wget='wget --hsts-file="${HOME}/.config/wget/wget-hsts" --no-check-certificate'

# ios -> open simulator
alias ios='open -a Simulator.app'

# xcode -> open xcode
alias xcode='open -a Xcode.app'

# br -> open brave
alias brave='open -a "Brave Browser.app"'

# cr-dev -> open chrome-dev
alias chrome-dev='open -a "Google Chrome" --args --remote-debugging-port=9229'

# mon-icloud -> watch icloud sync
alias mon_icloud="brctl monitor com.apple.CloudDocs | grep %"

# spotoff -> disable spotlight
alias spot_off='sudo mdutil -a -i off'

# spoton -> enable spotlight
alias spot_on='sudo mdutil -a -i on'

# show_files -> show files
alias shf='defaults write com.apple.finder AppleShowAllFiles TRUE; killall Finder /System/Library/CoreServices/Finder.app'

# hide_files -> hide files
alias hhf='defaults write com.apple.finder AppleShowAllFiles FALSE; killall Finder /System/Library/CoreServices/Finder.app'

export LS_COLORS='*.*=0;31:di=01;34:ln=01;36:ex=0;32:*.mp4=01;93:*.mov=01;93:*.mp3=01;93:*.dmg=0;35:*.zip=0;35:'

if gls &>/dev/null; then
  alias ls="gls -F --color"
  alias l="gls -lG --color"
  alias ll="gls -lAh --color --group-directories-first"
  alias la='gls -A --color'
fi

