#!/usr/bin/env zsh

# fzf completions and keybindings
source /opt/homebrew/opt/fzf/shell/completion.zsh
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

# fzf base options
export FZF_DEFAULT_OPTS="\
  --height=60% \
  --layout=reverse \
  --prompt='> ' \
  --walker-skip=.git,node_modules,target,Library,Pictures,Documents,Movies,Music,.Trash \
  --tmux=center \
  --no-info --no-scrollbar --no-hscroll \
  --margin=0 --padding=0 \
  --bind='ctrl-space:toggle' \
  --bind='ctrl-o:toggle-preview' \
  --bind='ctrl-s:toggle-sort' \
  --bind='ctrl-y:execute-silent(echo {+} | pbcopy)' \
  --bind='ctrl-e:execute(codium {+})' \
  --bind='ctrl-n:execute(nvim {+})'"

# fzf dir search
export FZF_CTRL_T_OPTS="\
  --header='Directories' \
  --walker=dir,hidden,follow \
  --preview='tree -C {} | head -200' \
  --bind='enter:execute(nvim {})+abort'"

# fzf file search
export FZF_ALT_C_OPTS="\
  --header='Files' \
  --walker=file \
  --preview='bat -n --color=always {}' \
  --bind='enter:execute(nvim {} +1)'"