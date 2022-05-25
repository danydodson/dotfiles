#!/bin/bash

unalias -a

# fixes
alias cd='cd '
alias sudo='sudo '

# safer
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# shell

alias l='gls -AFlh --group-directories-first'
alias cat='bat'
alias o='open'
alias src=". ~/.zshrc"
alias tree='exa --tree --level=2'
alias r="ranger"
alias uuid='uuidgen'

# pretty paths
alias fpath='echo -e ${FPATH//:/\\n}'
alias path='echo -e ${PATH//:/\\n}'

# set custom yarnrc location
alias yarn='yarn --use-yarnrc $HOME/.config/yarn/yarnrc'

# fixes brew error
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

# get public key
alias pubkey='more ~/.ssh/id_rsa.pub | pbcopy | echo "=> Public key copied to pasteboard."'

# flush
alias flush='sudo killall -HUP mDNSResponder'

# toggle spotlight
alias spotoff='sudo mdutil -a -i off'
alias spoton='sudo mdutil -a -i on'

# system apps
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias ios='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
