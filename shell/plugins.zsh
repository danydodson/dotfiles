# plugins

# oh-my-zsh -> plugins
plugins+=(brew git pyenv zsh-syntax-highlighting zsh-history-substring-search)

# oh-my-zsh -> my-zsh-completions
source $HOME/.config/omz/custom/plugins/my-zsh-completions/zsh-completions.plugin.zsh

# oh-my-zsh -> source
source $HOME/.config/omz/oh-my-zsh.sh

# iterm2 -> loads shell integration
test -e $DOTFILES/config/iterm2/iterm2_shell_integration.zsh && source $DOTFILES/config/iterm2/iterm2_shell_integration.zsh || true

# vscode -> loads shell integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

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
export FZF_DEFAULT_OPTS="--ansi --layout=reverse  --inline-info --height=60% --border --prompt='> ' --bind 'ctrl-o:toggle-preview' --bind 'ctrl-s:toggle-sort' --bind 'ctrl-space:toggle'"

# fzf -> ctrl-t returns only files and previews them with bat
export FZF_CTRL_T_OPTS="--walker-skip  .git,node_modules,target --preview 'bat -n  -color=always {}'  --bind 'enter:become(nvim {+})'"

# fzf -> ctrl0c returns only dirs and previews a file tree
export FZF_ALT_C_OPTS="--walker-skip  .git,node_modules,target --preview 'tree -C (nvim {+})'"

# fzf -> fd for listing path candidates
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" "$dir" "$1"
}

# fzf -> fd used to generate dir list for completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" "$dir" "$1"
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

# add colors to ls command
if [ -f "/usr/local/bin/gdircolors"  ] || [ -f "/usr/bin/gdircolors"  ] || [ -f "/opt/homebrew/bin/gdircolors" ]; then
	eval "$( gdircolors -b "${DOTFILES}"/config/dircolors/dircolors )"
fi

# fzf -> completion options
autoload -U compinit && compinit

# de-dupe $PATH
typeset -U path
typeset -U fpath
