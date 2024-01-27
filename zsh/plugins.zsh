# External plugins

# oh-my-zsh -> plugins
plugins+=(brew fd macos fzf pyenv nvm npm zsh-syntax-highlighting zsh-history-substring-search)

# oh-my-zsh -> my-zsh-completions
source "$HOME/.config/oh-my-zsh/custom/plugins/my-zsh-completions/zsh-completions.plugin.zsh"

# oh-my-zsh -> source
# fpath+="${ZSH_CUSTOM:-"$ZSH:-~/.config/oh-my-zsh/custom"}/plugins/zsh-completions/src"

# oh-my-zsh -> source
source "$HOME/.config/oh-my-zsh/oh-my-zsh.sh"

# starship.rs
eval "$(starship init zsh)"

# iterm2 -> loads shell integration
source "$HOME/.config/zsh/iterm2_shell_integration.zsh"

# direnv hook
eval "$(direnv hook zsh)"

# gpg
export GPG_TTY=$(tty)

# 1password -> load plugins and completions
source $HOME/.config/op/plugins.sh
eval "$(op completion zsh)"
eval "$(__load_op_completion)"
compdef _op op

# fzf -> setup fzf
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi

# fzf -> get completions
source "/opt/homebrew/opt/fzf/shell/completion.zsh"

# fzf -> get key bindings
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# fzf -> check for local config
# [[ ! -f $HOME/.config/fzf/fzf.zsh ]] || source $HOME/.config/fzf/fzf.zsh

# fzf -> defaults
export FZF_DEFAULT_OPTS="--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down --preview 'bat --color=always {}'"

# fzf -> preview current directory
alias preview="fzf --preview 'bat --color \"always\" --style \"numbers\" --line-range \":500\" {}'"

# start the ssh-agent
eval "$(ssh-agent -s)" >/dev/null 2>&1

# bun -> load completions
[ -s "$HOME/.config/bun/_bun" ] && source "$HOME/.config/bun/_bun"

# cargo -> load env
[[ ! -f ~/.config/cargo/env ]] || . ~/.config/cargo/env

# pyenv -> load pyenv
eval "$(pyenv init --path)"

# ngrok -> completions
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

# nvm -> completions
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"

# nvm -> load nvmrc if available
load_nvmrc() {
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
add-zsh-hook chpwd load_nvmrc
load_nvmrc

# heroku -> completions
export HEROKU_AC_ZSH_SETUP_PATH=/Users/Dany/Library/Caches/heroku/autocomplete/zsh_setup &&
  test -f $HEROKU_AC_ZSH_SETUP_PATH &&
  source $HEROKU_AC_ZSH_SETUP_PATH
