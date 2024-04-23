# plugins

# oh-my-zsh -> plugins
plugins+=(brew git zsh-syntax-highlighting zsh-history-substring-search)

# oh-my-zsh -> my-zsh-completions
source $DOTFILES/custom/plugins/my-zsh-completions/zsh-completions.plugin.zsh

# oh-my-zsh -> source
source $DOTFILES/config/omz/oh-my-zsh.sh

# run -> p10k configure
[[ ! -f ~/.dotfiles/prompts/p10k-lean.zsh ]] || source ~/.dotfiles/prompts/p10k-lean.zsh

# zsh -> completions generator
# source "$ZSH_CUSTOM/plugins/my-zsh-completions/src/custom/genhelp/zsh-completion-generator.plugin.zsh"

# iterm2 -> loads shell integration
source $DOTFILES/config/iterm2/iterm2_shell_integration.zsh

# op -> load completions
eval $(op completion zsh)
compdef _op op

# start the ssh-agent
eval "$(ssh-agent -s)" >/dev/null 2>&1

# cargo -> load env
[[ ! -f $HOME/.config/cargo/env ]] || . $HOME/.config/cargo/env

# pyenv -> load pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval $(pyenv init --path)
fi

# ngrok -> completions
if command -v ngrok &>/dev/null; then
  eval $(ngrok completion)
fi

# fzf -> get completions
source /opt/homebrew/opt/fzf/shell/completion.zsh

# fzf -> get key bindings
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# fzf -> default options
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --height=60% --border --prompt='> ' --bind 'ctrl-o:toggle-preview' --bind 'ctrl-s:toggle-sort' --bind 'ctrl-space:toggle'"

# fzf -> default ctrl-t options
export FZF_CTRL_T_OPTS="--walker-skip .git,node_modules,target --preview 'bat -n --color=always {}'"

# fzf -> default alt-c options
export FZF_ALT_C_OPTS="--walker-skip .git,node_modules,target --preview 'tree -C {}'"

# fzf -> fd for listing path candidates
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# fzf -> fd used to generate dir list for completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# fzf -> advanced options
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd) fzf --preview 'tree -C {} | head -200' "$@" ;;
    export | unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
    ssh) fzf --preview 'dig {}' "$@" ;;
    *) fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# fzf -> completion options
autoload -U compinit && compinit

# de-dupe $PATH
typeset -U path
typeset -U fpath
