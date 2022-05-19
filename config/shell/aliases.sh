#!/bin/bash

unalias -a

alias b='brew'
alias cat='bat'
alias g='git'
alias loc='tokei'
alias man='tldr'
alias r="ranger"

alias c="clear"
alias cp='cp -i'
alias fpath='echo -e ${FPATH//:/\\n}'
alias mv='mv -i'
alias o='open'
alias path='echo -e ${PATH//:/\\n}'
alias reload='exec ${SHELL} -l'
alias rm='rm -i'
alias src=". ~/.zshrc"
alias sudo='sudo '
alias tree='exa --tree --level=2'
alias uuid='uuidgen'

alias sup='sudo softwareupdate -i -a'
alias spotoff='sudo mdutil -a -i off'
alias spoton='sudo mdutil -a -i on'
alias npmg='npm list -g --depth 0'
alias yarng='yarn global list'

alias dsk="cd ~/Desktop"
alias dev="cd ~/Developer"
alias docs="cd ~/Documents"
alias dots="cd ~/Developer/Dotfiles"
alias down="cd ~/Downloads"

alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias ios='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'

alias docker_run_explainshell='docker container run --name explainshell --restart always -p 5000:5000 -d spaceinvaderone/explainshell'
