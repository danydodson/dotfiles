#!/usr/bin/env bash

cp ~/.dotfiles/zshrc/.hushlogin ~/.hushlogin

ln -s -f ~/.dotfiles/zshrc/.zshrc ~/.zshrc
ln -s -f ~/.dotfiles/zshrc/.zshrc ~/.config/zsh/.zshrc

ln -s -f ~/.dotfiles/config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
ln -s -f ~/.dotfiles/config/atuin/config.toml ~/.config/atuin/config.toml
ln -s -f ~/.dotfiles/config/git/config ~/.config/git/config
ln -s -f ~/.dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -s -f ~/.dotfiles/config/mpv/mpv.conf ~/.config/mpv/mpv.conf
ln -s -f ~/.dotfiles/config/ranger/rc.conf ~/.config/ranger/rc.conf
ln -s -f ~/.dotfiles/config/skhd/skhdrc ~/.config/skhd/skhdrc
ln -s -f ~/.dotfiles/config/vim/vimrc ~/.config/vim/vimrc
ln -s -f ~/.dotfiles/config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
ln -s -f ~/.dotfiles/config/yabai/yabairc ~/.config/yabai/yabairc

sudo ln -sfn /opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk
