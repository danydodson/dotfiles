# External plugins

#######################################################################
# oh-my-zsh                                                           #
#######################################################################

plugins=(aliases brew copypath docker docker-compose git heroku macos zsh-tab-title)

# oh-my-zsh.sh
source "${HOME}/.config/local/share/oh-my-zsh/oh-my-zsh.sh"

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

export FZF_DEFAULT_COMMAND="rg --files"
export FZF_COMPLETION_OPTS="--reverse --border --exact --height 40%"
export FZF_DEFAULT_OPTS="
  --reverse 
  --border 
  --exact 
  --ansi
  --bind='ctrl-k:preview-up'
  --bind='ctrl-j:preview-down'
  --bind='ctrl-r:toggle-all'
  --height='100%'
  --preview-window='right:60%'
"

# fzf completion
source /opt/homebrew/opt/fzf/shell/completion.zsh

# Load Key bindings
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# Preview current directory
alias preview="fzf --preview 'bat --color \"always\" {}'"

if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# Supports ctrl+o to open selected file in the text editor
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(e {})+abort'"

#######################################################################
# Setup zsh-tab-title plugin                                          #
#######################################################################

ZSH_TAB_TITLE_ONLY_FOLDER=true
ZSH_TAB_TITLE_CONCAT_FOLDER_PROCESS=true

#######################################################################
# iterm2                                                              #
#######################################################################

source "${HOME}/.config/iterm2/iterm2_shell_integration.zsh"

#######################################################################
# z                                                                   #
#######################################################################

source /opt/homebrew/etc/profile.d/z.sh
