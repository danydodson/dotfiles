#!/usr/bin/env bash

# unalias -a

# sudo
alias se='sudo -e'
alias root='sudo -s'

# src -> source
alias src="source ~/.zshrc"

# fixes
alias cp='cp -i'
alias mv='mv -i'
alias dirs='dirs -v'
alias rm='trash'

# ls -> pretty ls
alias ls='/opt/homebrew/bin/gls --color=auto --group-directories-first'
alias la='ls -A'
alias ll='ls -lAh'
alias l='ls -lh'

# nvim
alias v='nvim'
alias vi="nvim"
alias vim="nvim"
alias r='ranger'

# more nvim
alias vc='NVIM_APPNAME=nvim-chad nvim'
alias vd='NVIM_APPNAME=nvim-dany nvim'
alias ve='NVIM_APPNAME=nvim-ecosse nvim'
alias vjl='NVIM_APPNAME=nvim-juanlopez nvim'
alias vn='NVIM_APPNAME=nvim-normal nvim'
alias vp='NVIM_APPNAME=nvim-primeagem nvim'
alias vsn='NVIM_APPNAME=nvim-s9tpepper nvim'
alias vj='NVIM_APPNAME=nvim-teej nvim'
alias vt='NVIM_APPNAME=nvim-togglebyte nvim'

# npm
alias n='npm'
alias pn='pnpm'

# list global packages
alias lsg-npm='npm ls -g --depth 0'
alias lsg-yarn='yarn global list'
alias lsg-bun='bun pm ls --global'

# dl
alias curl='curl --silent'
alias wget='wget --hsts-file="${HOME}/.config/wget/wget-hsts" --no-check-certificate'

# bat
alias bat='bat --color=always'
alias cat='bat'
alias man='batman'
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# tools
alias top="sudo htop"
alias neo='neofetch'
alias uuid='uuidgen'
alias ping='prettyping --nolegend -Anc 5 1.1.1.1'

# b -> brew
alias b='brew'
alias bb='brew bundle'

# bbu -> brew update and clean
alias bbu='b update && b upgrade && b autoremove && b cleanup --prune=all -s'

# bb -> brew buundle
alias bbdump='bb dump -f --file="~/.dotfiles/macos/brewfile"'
alias bbinstall='bb install --file="~/.dotfiles/macos/brewfile"'
alias bbclean='bb cleanup --file="~/.dotfiles/macos/brewfile"'
alias bbcheck='bb check --file="~/.dotfiles/macos/brewfile"'

# afk ->  open screen saver
alias afk="/System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine"

# sshm1 -> casanova@macbook
alias sshm1="ssh casanova@192.168.0.5"

# ssh -> create a public key copy it to the clipboard
alias sshkeygen='ssh-keygen -o -a 100 -t ed25519'
alias pubkey='more ~/.config/ssh/id_rsa.pub | pbcopy | echo "=> Public key copied to pasteboard."'

# paths
alias fpath='echo -e ${FPATH//:/\\n}'
alias path='echo -e ${PATH//:/\\n}'

# spot -> on off
alias spot_off='sudo mdutil -a -i off'
alias spot_on='sudo mdutil -a -i on'

# macos -> launch apps
alias ios='open -a Simulator.app'
alias xcode='open -a Xcode.app'
alias mon_icloud="brctl monitor com.apple.CloudDocs | grep %"
alias chrome-dev='open -a "Google Chrome" --args --remote-debugging-port=9229'

# syspl -> pkgutil
alias sys-pl='pkgutil --pkgs'

# syscpu -> show cpu info
alias sys-cpu='sysctl -n machdep.cpu.brand_string'

# scutil -> name host dns proxy network
alias sys-get-computername='scutil --get ComputerName'
alias sys-get-localhostname='scutil --get LocalHostName'
alias sys-get-hostname='scutil --get HostName'
alias sys-get-dns='scutil --dns'
alias sys-get-proxy='scutil --proxy'
alias sys-get-network-interface='scutil --nwi'

# sys-get-network-location='scutil --get NetworkLocation'
alias sys-uti-file='mdls -name kMDItemContentTypeTree '

# lsregister -> launch services register
alias lsregister='/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister'
