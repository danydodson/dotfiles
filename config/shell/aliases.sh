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

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

alias sup='sudo softwareupdate -i -a'

alias spotoff='sudo mdutil -a -i off'
alias spoton='sudo mdutil -a -i on'

alias dev="cd ~/Developer/"
alias dots="cd ~/Developer/Dotfiles/"

alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias ios='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'

