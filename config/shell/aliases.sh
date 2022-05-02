#!/bin/bash
unalias -a

alias b='brew'
alias cat='bat'
alias g='git'
alias kill='fkill'
alias loc='tokei'
alias man='tldr'
alias py='/opt/homebrew/bin/python3'
alias python='/opt/homebrew/bin/python3'
alias pip='/opt/homebrew/bin/pip3'
alias r="ranger"

alias c="clear"
alias cp='cp -i'
alias fpath='echo -e ${FPATH//:/\\n}'
alias mv='mv -i'
alias o='open'
alias path='echo -e ${PATH//:/\\n}'
alias path_helper='/usr/libexec/path_helper'
alias reload="exec ${SHELL} -l"
alias src=". ~/.zshrc"
alias sudo='sudo '
alias tree='exa --tree --level=2'

alias dots="cd ~/Dotfiles"
alias developer="cd ~/Developer"
alias served="cd ~/Developer/Served"
alias movies="cd ~/Movies"

alias sup='sudo softwareupdate -i -a'
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

alias spotoff='sudo mdutil -a -i off'
alias spoton='sudo mdutil -a -i on'

alias lsgnpm='npm list -g --depth 0'
alias lsgyarn='yarn global list'

alias flush='dscacheutil -flushcache && killall -HUP mDNSResponder'
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias localip='ipconfig getifaddr en0'


alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias ios='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'

alias docker_run_explainshell='docker container run --name explainshell --restart always -p 5000:5000 -d spaceinvaderone/explainshell'
