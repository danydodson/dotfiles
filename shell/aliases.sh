#!/usr/bin/env bash

# unalias -a

# fixes
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

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
alias bu='brew update && brew upgrade && brew autoremove && brew cleanup --prune=all -s'

# pn -> pnpm
alias pn='pnpm'
alias pni='pnpm install'
alias pnb='pnpm build'
alias pns='pnpm run start'
alias pnd='pnpm run dev'
alias pnvite='pnpm create vite'

# n -> npm
alias n='npm'
alias ni='n install'
alias nb='npm build'
alias ns='n run start'
alias nd='n run dev'
alias npmvite='npm create vite@latest'

# create-ic -> create-ic-app
alias create-ic='npx create-ic-app@latest'

# hts -> http-server
alias hts='http-server'

# lvs -> live-server
alias lvs='live-server'

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

# pyg -> pretty python
alias pyg='pygmentize -O style=rrt -f console256 -g'

# uuid -> generate a uuid
alias uuid='uuidgen'

# top -> system monitor
alias top="sudo htop"

# neo -> system details
alias neo='neofetch'

# ping -> nicer ping
alias ping='prettyping --nolegend'

# rmquar -> removes quarantine property from file
alias rmquar='xattr -d com.apple.quarantine'

# spotoff -> disable spotlight
alias spotoff='sudo mdutil -a -i off'

# spoton -> enable spotlight
alias spoton='sudo mdutil -a -i on'

# ssh-dany-macbook -> dany@macbook
alias sshm1="ssh dany@192.168.0.3"

# sshkeygen -> create a public key
alias sshkeygen='ssh-keygen -o -a 100 -t ed25519'

# pubkey -> copy key to clipboard
alias pubkey='more ~/.config/ssh/id_rsa.pub | pbcopy | echo "=> Public key copied to pasteboard."'

# docker -> m4b-tool
alias m4b-tool='docker run -it --rm -u $(id -u):$(id -g) -v "$(pwd)":/mnt sandreas/m4b-tool:latest'

# mon-icloud -> watch icloud sync
alias mon-icloud="brctl monitor com.apple.CloudDocs | grep %"

# curl -> with configs
alias curl='curl -K "$HOME/.config/curl/curlrc" --silent'

# wget -> with configs
alias wget='wget --config="${HOME}/.config/wget/wgetrc" --hsts-file="${HOME}/.config/wget/wget-hsts" --no-check-certificate'

# fpath -> pretty fpath
alias fpath='echo -e ${FPATH//:/\\n}'

# path -> pretty path
alias path='echo -e ${PATH//:/\\n}'

# ytd -> default directory
alias ytd='yt-dlp -o ~/Movies'

# ios -> open simulator
alias ios='open -a Simulator.app'

# xcode -> open xcode
alias xcode='open -a Xcode.app'

# br -> open brave
alias brave='open -a "Brave Browser.app"'

# cr-dev -> open chrome-dev
alias chrome-dev='open -a "Google Chrome" --args --remote-debugging-port=9229'

# ls -> gls
alias_ls() {
  alias ls="gls --color=always --group-directories-first --time-style=+%Y%m%d --ignore='Icon'$'\r' --ignore='.DS_Store*' --ignore='.megaignore*'"
  alias la="gls -A --color=always --ignore='Icon'$'\r' --ignore='.DS_Store*' --ignore='.megaignore*'"
  alias l="gls -A -l --color=always --group-directories-first --ignore='Icon'$'\r' --ignore='.DS_Store*' --ignore='.megaignore*'"
  alias ll="gls -l -X --color=always --time-style=+%Y%m%d --ignore='Icon'$'\r' --ignore='.DS_Store*' --ignore='.megaignore*'"
  alias kk='ll'
}
alias_ls

# vim: set filetype=zsh: