# plugin settings

# oh-my-zsh -> plugins
plugins+=(brew git urltools systemd pnpm-shell-completion zsh-syntax-highlighting zsh-history-substring-search)

# oh-my-zsh -> my-zsh-completions
source $HOME/.config/omz/custom/plugins/my-zsh-completions/zsh-completions.plugin.zsh

# oh-my-zsh -> source
source $HOME/.config/omz/oh-my-zsh.sh

# iterm2 -> loads shell integration
test -e $DOTFILES/config/iterm/iterm2_shell_integration.zsh && source $DOTFILES/config/iterm/iterm2_shell_integration.zsh || true

# vscode -> loads shell integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# op -> load completions
eval "$(op completion zsh)"
eval "$(__load_op_completion)"
compdef _op op

# gh -> load completions
eval "$(gh copilot alias -- zsh)"

# start the ssh-agent
eval "$(ssh-agent -s)" >/dev/null 2>&1

# cargo -> load env
[[ ! -f $HOME/.config/cargo/env ]] || . $HOME/.config/cargo/env

# pyenv -> load pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# ngrok -> completions
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

# fzf -> get completions
source /opt/homebrew/opt/fzf/shell/completion.zsh

# fzf -> get key bindings
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# fzf -> default options
export FZF_DEFAULT_OPTS="--ansi --layout=reverse --inline-info --height=60% --border --walker-skip .git,.github,node_modules,target,Library,Pictures,Music,.Trash,Desktop--prompt='> ' --bind 'ctrl-o:toggle-preview' --bind 'ctrl-s:toggle-sort' --bind 'ctrl-space:toggle'"

# fzf -> ctrl-t returns only files and previews them with bat
export FZF_CTRL_T_OPTS="--preview 'bat -n {}' --bind 'enter:become(vim {} < /dev/tty > /dev/tty)'"

# fzf -> ctrl+c returns only dirs and previews a file tree
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# zsh -> completion options
autoload -U compinit && compinit

# add colors to ls command
if [ -f "/opt/homebrew/bin/gdircolors" ]; then
	eval "$(gdircolors -b "${DOTFILES}"/config/colors/dircolors)"
fi

# de-dupe $PATH
typeset -U path
typeset -U fpath
