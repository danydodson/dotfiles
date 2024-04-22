# plugins

# oh-my-zsh -> plugins
plugins+=(brew git pnpm-shell-completion zsh-syntax-highlighting zsh-history-substring-search)

# oh-my-zsh -> my-zsh-completions
source "$DOTFILES/config/zsh/custom/plugins/my-zsh-completions/zsh-completions.plugin.zsh"

# oh-my-zsh -> source
source "$DOTFILES/config/omz/oh-my-zsh.sh"

# run -> p10k configure
[[ ! -f ~/.dotfiles/zsh/p10k.zsh ]] || source ~/.dotfiles/zsh/p10k.zsh

# iterm2 -> loads shell integration
source "$DOTFILES/config/iterm2/iterm2_shell_integration.zsh"

# gpg_tty -> config for instant prompt
export GPG_TTY=$(tty)

# op -> load completions
eval "$(op completion zsh)"
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

# load and initialise completions
autoload -U compinit && compinit -i

# de-dupe $PATH
typeset -U path
