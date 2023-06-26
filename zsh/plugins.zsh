# External plugins

#######################################################################
# oh-my-zsh
#######################################################################

plugins+=(brew docker docker-compose macos npm nvm pip pipenv zsh-completions)

source "${HOME}/.config/local/share/oh-my-zsh/oh-my-zsh.sh"

#######################################################################
# zsh-syntax-highlighting
#######################################################################

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#######################################################################
# zsh-history-substring-search
#######################################################################

source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#######################################################################
# zsh-autosuggestions
#######################################################################

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

#######################################################################
# 1password
#######################################################################

eval "$(op completion zsh)"
compdef _op op

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

#######################################################################
# pyenv
#######################################################################

command -v pyenv >/dev/null || path-prepend "$PYENV_ROOT/bin"
eval "$(pyenv init -)"

#######################################################################
# heroku
#######################################################################

export HEROKU_AC_ZSH_SETUP_PATH=/Users/Dany/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH

#######################################################################
# angular-cli completions
#######################################################################

source <(ng completion script)

#######################################################################
# fzf
#######################################################################

# fzf completion
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# Auto-completion
[[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2>/dev/null

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
# iterm2
#######################################################################

source /Users/Dany/.config/zsh/.iterm2_shell_integration.zsh

#######################################################################
# z
#######################################################################

source /opt/homebrew/etc/profile.d/z.sh
