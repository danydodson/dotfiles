export ITERM2_CONFIG="$HOME/.config/iterm2"

# curl -L https://iterm2.com/shell_integration/zsh \
# -o $DOTFILES/.iterm2_shell_integration.zsh

test -e "${ITERM2_CONFIG}/iterm2_shell_integration.zsh.symlink" && source "${ITERM2_CONFIG}/iterm2_shell_integration.zsh.symlink"
