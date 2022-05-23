#!/bin/bash

unalias -a

alias cat='bat'
alias g='git'
alias nvm='fnm'
alias r="ranger"

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias c="clear"
alias o='open'

alias src=". ~/.zshrc"
alias sudo='sudo '
alias tree='exa --tree --level=2'
alias uuid='uuidgen'

alias fpath='echo -e ${FPATH//:/\\n}'
alias path='echo -e ${PATH//:/\\n}'

alias yarn='yarn --use-yarnrc $HOME/.config/yarn/yarnrc'
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

alias sup='sudo softwareupdate -i -a'

alias npmg='npm list -g --depth 0'
alias yarng='yarn global list'

alias flush='sudo killall -HUP mDNSResponder'

alias pubkey='more ~/.ssh/id_rsa.pub | pbcopy | echo "=> Public key copied to pasteboard."'

alias spotoff='sudo mdutil -a -i off'
alias spoton='sudo mdutil -a -i on'

alias dev="cd ~/Developer/"
alias dots='cd $DOTFILES'

alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias ios='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
