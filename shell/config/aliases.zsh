#!/usr/bin/env zsh

# cd
alias ~="cd ~"
alias ...="cd ~"
alias ..="cd .."

# open
alias o="open"
alias v="nvim"
alias e="codium"

# ssh
alias ssh-rawdog="ssh ubuntu@18.235.113.176"

# npm globals
alias lsg-npm="npm ls -g --depth 0"

# bat
alias cat='bat'
alias -g :h='-h 2>&1 | bat --language=help'
alias -g :h='--help 2>&1 | bat --language=help'

# dumps
alias hd="hexdump -C"
alias md5sum="md5"
alias sha1sum="shasum"

# file metadata
alias sys_mdls="mdls -name kMDItemContentTypeTree "
alias met="mdls -name kMDItemContentType -name kMDItemContentTypeTree -name kMDItemKind"

# run zsh startup time log
alias zsh-time="zsh -i -x &> $HOME/.dotfiles/zsh-startup.log"

# system information
alias displays="system_profiler SPDisplaysDataType"
alias cpu="sysctl -n machdep.cpu.brand_string"
alias ram="top -l 1 -s 0 | grep PhysMem"

# tmux
alias tm="tmux -f ~/.config/tmux/tmux.conf"
alias tn="tm new"
alias tl="tm ls"
alias ta="tm attach"
alias tk="tm kill-session"
alias td="tm detach"

# ctrl+p runs tms script
bindkey -s '^p' "tms\n"

# ctrl+w new tmux session
bindkey -s '^w' "tmux new\n"

# dl
alias get="curl $HOME/.dotfiles/config/curl/curlrc -O"
alias wget="wget --config=$HOME/.dotfiles/config/wget/wgetrc --no-check-certificate"

# capture http requests and traffic
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en0 -n -s 0 -w — | grep -a -o -E \"Host\: .*|GET \/.*\""

# speedtest
alias speedtest="wget -O /dev/null http://speed.transip.nl/100mb.bin"

# brew
alias bl="brew leaves | xargs brew desc --eval-all"
alias blc="brew ls --casks | xargs brew desc --eval-all"

# kill
alias fkill="ps -e | fzf | awk '{print $1}' | xargs kill"
alias mbkill="killall SystemUIServer NotificationCenter"
alias oskill="killfinder && killdock && killmenubar"

# ls
alias ls='/opt/homebrew/bin/gls --color=auto --group-directories-first -I .DS_Store -I .Trash -I "Icon'$'\r"'
alias l="ls -AhLg --no-group --time-style=iso"
alias ll="lsd -Al"
alias la="ls -A"

# browsers
alias firefox="open -a Firefox.app"
alias brave="open -a 'Brave Browser.app'"
alias twilight="open -a Twilight.app"

# spotlight on/off
alias spotlight-off="sudo mdutil -a -i off"
alias spotlight-on="sudo mdutil -a -i on"

# transmission-cli
alias trd="transmission-daemon"
alias tr="transmission-remote --auth stache:open"
alias trw="watch --interval 2 'transmission-remote -n 'stache:open' -l'"

# js repl
alias jscl="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Helpers/jsc"

# start screen saver
alias afk="open /System/Library/CoreServices/ScreenSaverEngine.app"

# log off
alias logoff="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# go to dir
alias dot="cd $HOME/.dotfiles"
alias docs="cd $HOME/Documents"
alias downs="cd $HOME/Downloads"
alias public="cd $HOME/Public"
alias plugins="cd $HOME/Developer/plugins"
alias repos="cd $HOME/Developer/repos"
alias scripts="cd $HOME/Developer/scripts"
alias served="cd $HOME/Developer/served"

# open in codium
alias e-nvim="codium $HOME/.dotfiles/config/nvim"
alias e-tmux="codium $HOME/.dotfiles/config/tmux"
alias e-us="codium $HOME/Developer/served/userscripts"
alias e-fox="codium '$HOME/Library/Application Support/Firefox/Profiles/18jwsaux.default-release/chrome'"

# open in nvim
alias v-ghostty="nvim $HOME/.dotfiles/config/ghostty/config"
alias v-tmuxconf="nvim $HOME/.dotfiles/config/tmux/tmux.conf"
alias v-zshrc="nvim $HOME/.dotfiles/shell/zsh/zshrc"
alias v-zshenv="nvim $HOME/.dotfiles/shell/zsh/zshenv"
alias v-zprofile="nvim $HOME/.dotfiles/shell/zsh/zprofile"
