#!/usr/bin/env zsh

# open
alias ~="cd ~"
alias ..="cd .."
alias o="open"
alias v="nvim"
alias cc="codium"
alias src="source $HOME/.zshrc"

# tmux
alias tn="tmux new"
alias tl="tmux ls"
alias ta="tmux attach"
alias tk="tmux kill-session"
alias td="tmux detach"
bindkey -s ^p "tms\n"
bindkey -s ^w "tmux new\n"

# file commands
alias hd="hexdump -C"
alias md5sum="md5"
alias sha1sum="shasum"
alias sys_mdls="mdls -name kMDItemContentTypeTree "

# bat
alias cat="bat"
alias -g :h='-h 2>&1 | bat --language=help --style=plain'
alias -g :h='--help 2>&1 | bat --language=help --style=plain'

# 
# alias sshrawdog=”ssh -X danny@unix.spartaglobal.com -R 52698:localhost:52698"

# get files
alias get="curl $HOME/.dotfiles/config/curl/curlrc -O"
alias wget="wget --config=$HOME/.dotfiles/config/wget/wgetrc --no-check-certificate"

# brew leaves
alias b-leaves="brew leaves | xargs brew desc --eval-all"
alias b-leaves-casks="brew ls --casks | xargs brew desc --eval-all"

# transmission
alias trd="transmission-daemon"
alias tr="transmission-remote --auth stache:open"
alias tra="tr -a"
alias trl="tr -l"
alias trs="tr -s"

# gls coreutils
alias ls='/opt/homebrew/bin/gls --color=auto --group-directories-first -I .DS_Store -I .Trash -I "Icon'$'\r"'
alias l="ls -AhLg --no-group --time-style=iso"
alias ll="lsd -Al"
alias la="ls -A"

# grep
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# edit in nvim
alias dotconf="cd $DOTFILES && nvim"
alias nvconf="cd $DOTFILES/.config/nvim && nvim"

# list global pkgs
alias lsg_npm="npm ls -g --depth 0"
alias lsg_yarn="yarn global list"
alias lsg_pnpm="pnpm ls -g"

# clean hidden files
alias rmds="find . -type f -name '*.DS_Store' -ls -delete"
alias rmnm="find . -type d -name 'node_modules' -ls -delete"

# directories
alias dotfiles="cd $HOME/.dotfiles"
alias dl="cd $HOME/Downloads"
alias plugins="cd $HOME/Developer/plugins"
alias repos="cd $HOME/Developer/repos"
alias served="cd $HOME/Developer/served"
alias temp="cd $HOME/Developer/temp"

# macos apps
alias spotlight_off="sudo mdutil -a -i off"
alias spotlight_on="sudo mdutil -a -i on"
alias brctl_monitor="brctl monitor com.apple.CloudDocs | grep %"
alias jscbin="/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Helpers/jsc"
alias lsregister="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister"

