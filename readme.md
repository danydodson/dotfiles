# dotfiles 🍩

![screenshot](/docs/zsh.png)

These are my personal dotfiles. The setup is based on [dotbot](https://github.com/danydodson/dotfiles) and aims to be as idempotent as possible.

## Enable Touch ID for sudo
Open Terminal and copy the local template: 
```bash
sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local.
```
Edit the new file: 
```bash
sudo nano /etc/pam.d/sudo_local.
```
Uncomment the line 
```bash
auth sufficient pam_tid.so 
```
by removing the #.


## Systems 🚀

- [Setup macos](/docs/macos-setup.md)

## LaunchAgents ⌨️

- [Setup launch agents](/docs/macos-setup.md)

## Git 🐙

- [Configure git](/docs/credentials.md)

## Yabai 🪟

- [Setup yabai](/docs/yabai.md)

## SketchyBar 🍫

- [Setup sketchybar](/docs/yabai.md)

## Neovim ⌨️

- [Setup nvim](/setup/nvim.sh)

## gpg 🔑

- [Setup gpg](/docs/credentials.md)

## Project config/tooling 🧢

- [Configure projects](/setup)
- [Local commands](/bin/)

## Fonts 💯

- [FiraCode Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode)
- [FiraMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraMono)
- [San Francisco Apple Fonts](https://developer.apple.com/fonts/)
- [Operator Mono](https://typography.com/blog/introducing-operator)

## Ansi & Colors 🎨

1. Go to [image-to-ansi](https://dom111.github.io/image-to-ansi) ([github repo](https://github.com/dom111/image-to-ansi)).
2. Upload image.
3. Enable true colors, set width to 46.

- [colorhexa.com](https://www.colorhexa.com/)
- [color-hex.com](https://www.color-hex.com/)
