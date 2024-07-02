#!/usr/bin/env bash

# copy files
cp ~/.dotfiles/zsh/zshrc ~/.zshrc
cp ~/.dotfiles/zsh/zshrc ~/.config/zsh/.zshrc
cp ~/.dotfiles/zsh/hushlogin ~/.hushlogin
cp ~/.dotfiles/config/ranger/commands.py ~/.config/ranger/commands.py
cp ~/.dotfiles/config/ranger/custom.py ~/.config/ranger/custom.py
cp ~/.dotfiles/config/ranger/rifle.conf ~/.config/ranger/rifle.conf
cp ~/.dotfiles/config/ranger/scope.sh ~/.config/ranger/scope.sh
cp ~/.dotfiles/config/ranger/colorschemes/ls_colors.py ~/.config/ranger/colorschemes/ls_colors.py
cp ~/.dotfiles/config/ssh/config ~/.ssh/config

# link files
ln -s -f ~/.dotfiles/config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -s -f ~/.dotfiles/config/atuin/config.toml ~/.config/atuin/config.toml
ln -s -f ~/.dotfiles/config/bottom/bottom.toml ~/.config/bottom/bottom.toml
ln -s -f ~/.dotfiles/config/git/config ~/.config/git/config
ln -s -f ~/.dotfiles/config/htop/htoprc ~/.config/htop/htoprc
ln -s -f ~/.dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -s -f ~/.dotfiles/config/kitty/launch-actions.conf ~/.config/kitty/launch-actions.conf
ln -s -f ~/.dotfiles/config/kitty/open-actions.conf ~/.config/kitty/open-actions.conf
ln -s -f ~/.dotfiles/config/mpv/mpv.conf ~/.config/mpv/mpv.conf
ln -s -f ~/.dotfiles/config/neofetch/config.conf ~/.config/neofetch/config.conf
ln -s -f ~/.dotfiles/config/ranger/rc.conf ~/.config/ranger/rc.conf
ln -s -f ~/.dotfiles/config/skhd/skhdrc ~/.config/skhd/skhdrc
ln -s -f ~/.dotfiles/config/tmux/tmux.conf ~/.config/tmux/tmux.conf
ln -s -f ~/.dotfiles/config/vim/vimrc ~/.config/vim/vimrc
ln -s -f ~/.dotfiles/config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
ln -s -f ~/.dotfiles/config/yabai/yabairc ~/.config/yabai/yabairc

# sudo ln -sfn /opt/homebrew/opt/openjdk ..?? >> /Library/Java/JavaVirtualMachines/openjdk .. ?
