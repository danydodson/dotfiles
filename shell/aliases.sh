#!/usr/bin/env bash

# unalias -a

# fixes
alias cp='cp -i'
alias mv='mv -i'

# keep
alias cp="nocorrect cp"
alias mv="nocorrect mv"

# trash
alias rm='trash-put'
alias tre='trash-empty'
alias trl='trash-list'
alias trr='trash-restore'

# dirs
alias dirs='dirs -v'

# sudo
alias se='sudo -e'
alias root='sudo -s'

# v -> open nvim
alias v='nvim'

# b -> brew
alias b='brew'
alias bs='b search'
alias bi='b info'
alias bu='b update && b upgrade && b autoremove && b cleanup --prune=all -s'
alias bbi='b bundle install --file="~/.dotfiles/macos/brewfile"'
alias bbc='b bundle cleanup --file="~/.dotfiles/macos/brewfile"'
alias bbd='b bundle dump --file="~/.dotfiles/macos/brewfile"'

# bun aliases
alias lsg-bun='bun pm ls --global'

# npm aliases
alias n='npm'
alias lsg-npm='npm ls -g --depth 0'

# pn -> pnpm
alias pn='pnpm'

# yarn aliases
alias lsg-yarn='yarn global list'

# lvs -> live-server
alias lvs='live-server'

# gcp -> github copilot
alias gcp='gh copilot'

# hts -> http-server
alias hts='http-server'

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

# man -> batman
alias man='batman'

# bt -> pretty print
alias bat='bat --color=always'

# cat -> use bat
alias cat='bat --paging=never'

# help -> pretty print
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

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

# syspl -> pkgutil
alias syspl='pkgutil --pkgs'

# syscpu -> show cpu info
alias syscpu='sysctl -n machdep.cpu.brand_string'

# lsregister -> launch services register
alias lsregister='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister'

# ls -> pretty ls
alias ls='/opt/homebrew/bin/gls --color=auto --group-directories-first --ignore=.Trash --ignore=.megaignore --ignore=.debris --ignore="Icon?"'
alias la='ls -A'
alias ll='ls -lAh'
alias l='ls -lh'

# scutil -> system configuration utility
# alias sys.get.computername='scutil --get ComputerName'
# alias sys.get.localhostname='scutil --get LocalHostName'
# alias sys.get.hostname='scutil --get HostName'
# alias sys.get.dns='scutil --dns'
# alias sys.get.proxy='scutil --proxy'
# alias sys.get.network.interface='scutil --nwi'
# alias sys.uti.file='mdls -name kMDItemContentTypeTree '
