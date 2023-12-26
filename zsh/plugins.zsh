# External plugins

#######################################################################
# oh-my-zsh
#######################################################################

plugins+=(macos brew nvm npm zsh-completions zsh-yarn-completions)

source $HOME/.config/local/share/oh-my-zsh/oh-my-zsh.sh

#######################################################################
# zsh-plugins
#######################################################################

source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh

#######################################################################
# fzf
#######################################################################

# fzf completion
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2>/dev/null

# Load Key bindings
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix --hidden --follow --exclude .git"
export FZF_DEFAULT_COMMAND="rg --files --column --line-number --no-heading --color=always --smart-case"
export FZF_COMPLETION_OPTS="--reverse --border --exact --height 40%"
export FZF_DEFAULT_OPTS="--height=40% --preview='bat {}' --preview-window=right:60%:wrap"
# export FZF_DEFAULT_OPTS="
#  --reverse 
#  --border 
#  --exact 
#  --ansi
#  --bind='ctrl-k:preview-up'
#  --bind='ctrl-j:preview-down'
#  --bind='ctrl-r:toggle-all'
#  --bind='ctrl-o:execute(e {})+abort'
#  --height='100%'
#  --preview-window='right:70%'
#  --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9
#  --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
#  --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
#  --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
# "

# Preview current directory
alias preview="fzf --preview 'bat --color \"always\" --style \"numbers\" --line-range \":500\" {}'"

[[ ! -f ~/.fzf.zsh ]] || source ~/.fzf.zsh

#######################################################################
# iterm2
#######################################################################

source /Users/Dany/.config/zsh/iterm2_shell_integration.zsh

#######################################################################
# 1password
#######################################################################

source $HOME/.config/op/plugins.sh
eval "$(op completion zsh)"
eval "$(__load_op_completion)"
compdef _op op

#######################################################################
# heroku autocomplete
#######################################################################

export HEROKU_AC_ZSH_SETUP_PATH=/Users/Dany/Library/Caches/heroku/autocomplete/zsh_setup &&
  test -f $HEROKU_AC_ZSH_SETUP_PATH &&
  source $HEROKU_AC_ZSH_SETUP_PATH

#######################################################################
# nvm
#######################################################################

export NVM_DIR="$HOME/.config/nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc