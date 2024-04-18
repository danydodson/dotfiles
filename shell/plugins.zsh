# plugins

# oh-my-zsh -> plugins
plugins+=(brew nvm git pnpm-shell-completion zsh-syntax-highlighting zsh-history-substring-search)

# oh-my-zsh -> my-zsh-completions
source "$DOTFILES/config/zsh/custom/plugins/my-zsh-completions/zsh-completions.plugin.zsh"

# oh-my-zsh -> source
source "$DOTFILES/config/oh-my-zsh/oh-my-zsh.sh"

# run -> p10k configure
[[ ! -f ~/.dotfiles/config/p10k/p10k.zsh ]] || source  ~/.dotfiles/config/p10k/p10k.zsh

# iterm2 -> loads shell integration
source "$DOTFILES/config/iterm2/iterm2_shell_integration.zsh"

# direnv hook -> configs for instant prompt
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

# gpg_tty -> config for instant prompt
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

# fzf -> defaults
export FZF_DEFAULT_OPTS="--bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down --preview 'bat --color=always {}'"

# fzf -> preview current directory
alias preview="fzf --preview 'bat --color \"always\" --style \"numbers\" --line-range \":500\" {}'"

# start the ssh-agent
eval "$(ssh-agent -s)" >/dev/null 2>&1

# cargo -> load env
[[ ! -f ~/.config/cargo/env ]] || . ~/.config/cargo/env

# pyenv -> load pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

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
