#!/bin/bash

unalias -a

# vars
h="$HOME"
dots="$DOTFILES"
de="$DEVELOPER"
se="$DEVELOPER/Serving"
gi="$DEVELOPER/Github"
co="$XDG_CONFIG_HOME"
doc="$XDG_DOCUMENTS_DIR"
dow="$XDG_DOWNLOAD_DIR"

# fixes
alias cd='cd '
alias sudo='sudo '

# pretty paths
alias fpath='echo -e ${FPATH//:/\\n}'
alias path='echo -e ${PATH//:/\\n}'

# safer
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# shell
alias cat='bat'
alias o='open'
alias r="ranger"
alias src=". ~/.zshrc"
alias tree='exa --tree --level=2'
alias uuid='uuidgen'

# set custom yarnrc location
alias yarn='yarn --use-yarnrc $HOME/.config/yarn/yarnrc'

# fixes brew error
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

# get public key
alias pubkey='more ~/.ssh/id_rsa.pub | pbcopy | echo "=> Public key copied to pasteboard."'

# mac store update
alias sup='sudo softwareupdate -i -a'

# flush
alias flush='sudo killall -HUP mDNSResponder'

# ls globals
alias npmg='npm list -g --depth 0'
alias yarng='yarn global list'

# toggle spotlight
alias spotoff='sudo mdutil -a -i off'
alias spoton='sudo mdutil -a -i on'

# system apps
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias ios='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
