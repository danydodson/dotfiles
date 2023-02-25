# External plugins

#######################################################################
# oh-my-zsh                                                           #
#######################################################################

plugins=(aliases brew docker macos npm fnm pip pipenv)

# oh-my-zsh.sh
source "${HOME}/.config/local/share/oh-my-zsh/oh-my-zsh.sh"

#######################################################################
# zsh-syntax-highlighting                                             #
#######################################################################

source "${ZSH}/custom/plugins/dracula-zsh-syntax-highlighting.sh"
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
# heroku                                                              #
#######################################################################

test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH

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

# fzf completion
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

# Load Key bindings
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

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
 --bind='ctrl-o:execute(e {})+abort'
 --height='100%'
 --preview-window='right:70%'
 --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9
 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
"

# Preview current directory
alias preview="fzf --preview 'bat --color \"always\" --style \"numbers\" --line-range \":500\" {}'"

if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

#######################################################################
# iterm2                                                              #
#######################################################################

test -e /Users/Dany/.config/zsh/.iterm2_shell_integration.zsh && source /Users/Dany/.config/zsh/.iterm2_shell_integration.zsh || true

#######################################################################
# z                                                                   #
#######################################################################

source /opt/homebrew/etc/profile.d/z.sh

#######################################################################
# affinidi cli                                                        #
#######################################################################

# eval $(affinidi autocomplete:script zsh)
