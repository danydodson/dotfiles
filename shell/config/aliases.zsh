#!/usr/bin/env zsh

# open
# alias o="open"
alias v="nvim"
# alias e="codium"

# ssh
alias ssh-rawdog="ssh ubuntu@18.235.113.176"

# termbin
alias tb="nc termbin.com 9999"

# npm globals
alias lsg-npm="npm ls -g --depth 0"


# bat
alias cat="bat"
alias -g :h="-h 2>&1 | bat --language=help"
alias -g :h="--help 2>&1 | bat --language=help"

# tmux
alias tm="tmux -f ~/.config/tmux/tmux.conf"
alias tn="tm new"
alias tl="tm ls"
alias ta="tm attach"
alias tk="tm kill-session"
alias td="tm detach"

# install nvim
alias nvinstall="nvim --headless '+Lazy! sync' +qa"

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

# dl
alias curl="curl --location --trace-time --trace-ascii - --insecure -O"
alias wget='wget --hsts-file="$HOME/.cache/wget/wget-hsts" --timestamping --no-parent --timeout=60 --tries=3 --retry-connrefused --trust-server-names --follow-ftp --server-response --no-check-certificate --progress=dot:binary'

# kill
alias fkill="ps -e | fzf | awk '{print $1}' | xargs kill"
alias mbkill="killall SystemUIServer NotificationCenter"
alias oskill="killfinder && killdock && killmenubar"

# ls
alias ls='/opt/homebrew/bin/gls --color=auto --group-directories-first -I .DS_Store -I .Trash -I "Icon'$'\r"'
alias l="ls -AhLg --no-group --time-style=iso"
alias ll="eza -al -s type --no-symlinks"
alias la="lsd -Al"

# spotlight on/off
alias spotlight-off="sudo mdutil -a -i off"
alias spotlight-on="sudo mdutil -a -i on"

# start screen saver
alias afk="open /System/Library/CoreServices/ScreenSaverEngine.app"

# log off
alias logoff="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
