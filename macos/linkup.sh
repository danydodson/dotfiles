#!/usr/bin/env bash

cp ~/.dotfiles/zsh/.zshrc ~/.zshrc

cp ~/.dotfiles/zsh/.hushlogin ~/.hushlogin

cp ~/.dotfiles/zsh/.zshrc ~/.config/zsh/.zshrc

# dots+=(
  # 'newItem'
  # 'aouther'
# )

# SOURCE=$HOME/.dotfiles

# TARGET=$HOME/.config/alacritty/alacritty.toml



# mkdir -p "$(dirname "$TARGET")" && ln -sf "${SOURCE}" "$TARGET}"

ln -s -f ~/.dotfiles/config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -s -f ~/.dotfiles/config/atuin/config.toml ~/.config/atuin/config.toml
ln -s -f ~/.dotfiles/config/bottom/bottom.toml ~/.config/bottom/bottom.toml
ln -s -f ~/.dotfiles/config/git/config ~/.config/git/config
ln -s -f ~/.dotfiles/config/htop/htoprc ~/.config/htop/htoprc
ln -s -f ~/.dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -s -f ~/.dotfiles/config/mpv/mpv.conf ~/.config/mpv/mpv.conf
ln -s -f ~/.dotfiles/config/neofetch/config.conf ~/.config/neofetch/config.conf
ln -s -f ~/.dotfiles/config/ranger/rc.conf ~/.config/ranger/rc.conf
ln -s -f ~/.dotfiles/config/skhd/skhdrc ~/.config/skhd/skhdrc
ln -s -f ~/.dotfiles/config/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -s -f ~/.dotfiles/config/vim/vimrc ~/.config/vim/vimrc
ln -s -f ~/.dotfiles/config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
ln -s -f ~/.dotfiles/config/yabai/yabairc ~/.config/yabai/yabairc

# sudo ln -sfn /opt/homebrew/opt/openjdk ..?? >> /Library/Java/JavaVirtualMachines/openjdk .. ?
