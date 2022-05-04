# External plugins

#######################################################################
# oh-my-zsh                                                           #
#######################################################################

plugins=(aliases brew heroku macos node npm ruby yarn)

# oh-my-zsh.sh
source "${HOME}/.config/local/oh-my-zsh/oh-my-zsh.sh"

#######################################################################
# zsh-syntax-highlighting                                             #
#######################################################################

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

#######################################################################
# zsh-history-substring-search                                        #
#######################################################################

source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#######################################################################
# zsh-autosuggestions                                                 #
#######################################################################

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#######################################################################
# fzf                                                                 #
#######################################################################

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_COMPLETION_OPTS='--reverse --border --exact --height 40%'
export FZF_DEFAULT_OPTS='
  --reverse 
  --border 
  --exact 
  --ansi
  --bind='ctrl-k:preview-up'
  --bind='ctrl-j:preview-down'
  --bind='ctrl-r:toggle-all'
  --height='100%'
  --preview-window='right:60%'
'

# fzf completion
source /opt/homebrew/opt/fzf/shell/completion.zsh

# Load Key bindings
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# Preview current directory
alias preview="fzf --preview 'bat --color \"always\" {}'"

if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# Supports ctrl+o to open selected file in the text editor
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(e {})+abort'"

#####################################################################################################################
# Setup history-search-multi-word plugin                                                                            #
#####################################################################################################################

# Number of entries to show (default is $LINES/3)
zstyle ":history-search-multi-word" page-size "14"
# Color in which to highlight matched, searched text (default bg=17 on 256-color terminals)
zstyle ":history-search-multi-word" highlight-color "fg=yellow,bold"
# Whether to perform syntax highlighting (default true)
zstyle ":plugin:history-search-multi-word" synhl "yes"
# Effect on active history entry. Try: standout, bold, bg=blue (default underline)
zstyle ":plugin:history-search-multi-word" active "underline"
# Whether to check paths for existence and mark with magenta (default true)
zstyle ":plugin:history-search-multi-word" check-paths "yes"
# Whether pressing Ctrl-C or ESC should clear entered query
zstyle ":plugin:history-search-multi-word" clear-on-cancel "no"

#####################################################################################################################
# Setup zsh-tab-title plugin                                                                                        #
#####################################################################################################################

ZSH_TAB_TITLE_ONLY_FOLDER=true
ZSH_TAB_TITLE_CONCAT_FOLDER_PROCESS=true

#####################################################################################################################
# Setup wakatime plugin                                                                                             #
#####################################################################################################################

ZSH_WAKATIME_PROJECT_DETECTION=true

#######################################################################
# other                                                               #
#######################################################################

# z
source /opt/homebrew/etc/profile.d/z.sh

# iTerm2 integration
source "${HOME}/.config/iterm2/iterm2_shell_integration.zsh"

# asdf
source /opt/homebrew/opt/asdf/libexec/asdf.sh

