# External plugins

#######################################################################
# oh-my-zsh                                                           #
#######################################################################

plugins=(aliases brew docker docker-compose gatsby heroku macos npm fnm pip pipenv yarn)

# oh-my-zsh.sh
source "${HOME}/.config/local/share/oh-my-zsh/oh-my-zsh.sh"

#######################################################################
# zsh-syntax-highlighting                                             #
#######################################################################

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
# fnm                                                                 #
#######################################################################

eval "$(fnm env --use-on-cd)"

#######################################################################
# pyenv                                                               #
#######################################################################

command -v pyenv >/dev/null || path-prepend "$PYENV_ROOT/bin"
eval "$(pyenv init -)"

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
 --preview-window='right:70%'
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
# iterm2                                                              #
#######################################################################

source "${HOME}/.config/iterm2/iterm2_shell_integration.zsh"

function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
  iterm2_set_user_var home $(echo -n $HOME)
}


#######################################################################
# z                                                                   #
#######################################################################

source /opt/homebrew/etc/profile.d/z.sh

#######################################################################
# autoenv                                                             #
#######################################################################

source /opt/homebrew/opt/autoenv/activate.sh
