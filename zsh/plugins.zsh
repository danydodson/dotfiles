# 

# oh-my-zsh -> plugins
plugins+=(brew git pnpm-shell-completion zsh-syntax-highlighting zsh-history-substring-search)

# oh-my-zsh -> my-zsh-completions
source $HOME/.config/omz/custom/plugins/my-zsh-completions/zsh-completions.plugin.zsh

# oh-my-zsh -> source
source $HOME/.config/omz/oh-my-zsh.sh

# add colors to ls command
if [ -f "/opt/homebrew/bin/gdircolors" ]; then
  eval "$(gdircolors -b "${DOTFILES}"/config/dircolors/dircolors)"
fi

# iterm2 -> loads shell integration
# test -e ~/.dotfiles/config/iterm2/shell_integration.zsh && source ~/.dotfiles/config/iterm2/shell_integration.zsh || true

# vscode -> loads shell path integration
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# op -> load completions
eval "$(op completion zsh)"
eval "$(__load_op_completion)"
compdef _op op

# gh -> load completions
eval "$(gh copilot alias -- zsh)"

# grunt -> load completions
eval "$(grunt --completion=zsh)"

# start the ssh-agent
eval "$(ssh-agent -s)" >/dev/null 2>&1

# cargo -> load env
[[ ! -f $HOME/.config/cargo/env ]] || . $HOME/.config/cargo/env

# pyenv -> load pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# atuin -> shell history
eval "$(atuin init zsh)"

# ngrok -> completions
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

# fzf -> get completions
source /opt/homebrew/opt/fzf/shell/completion.zsh

# fzf -> get key bindings
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# unset to avoid conflicts
unset FZF_DEFAULT_COMMAND

# fzf -> default options
export FZF_DEFAULT_OPTS="\
  --walker-skip=.git,node_modules,target,Library,Pictures,Documents,Music,.Trash \
  --bind 'ctrl-space:toggle' \
  --bind 'ctrl-o:toggle-preview' \
  --bind 'ctrl-s:toggle-sort' \
  --border=rounded\
  --layout=reverse \
  --info=right \
  --no-scrollbar \
  --highlight-line \
  --margin=1,3 \
  --padding=1,1 \
  --literal \
  --no-hscroll \
  --height=60% \
  --prompt='> ' \
  --ellipsis=' ...' \
  --tac \
  --ansi "

# fzf -> all types
export FZF_CTRL_T_OPTS="\
  --header='Fuzzy Searching...' \
  --walker=file \
  --preview 'bat -n --color=always {}' | xargs nvim"

# fzf -> just dirs
export FZF_ALT_C_OPTS="\
  --header='Go to Directory' \
  --walker=dir,hidden,follow \
  --preview 'tree -C {} | head -200'"

# zsh -> completion options
autoload -U compinit && compinit

# de-dupe $PATH
typeset -U path
typeset -U fpath

