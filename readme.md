# dotfiles [![wakatime](https://wakatime.com/badge/github/danydodson/dotfiles.svg)](https://wakatime.com/badge/github/danydodson/dotfiles)

This project is mostly inspired by [holeman dotfiles](#references). I've added [`oh-my-zsh`](https://ohmyz.sh/), changed the whole structure of the project, and added some new features.

## install

clone this project to your prefered location:

```bash
git clone https://github.com/danydodson/dotfiles.git ~/.dotfiles
```

then run startup.sh using a script name from scripts/setup as a parameter:

```bash
setup.sh foo.sh
```

or use parameter 'all' to run them all sequentially:

```bash
setup.sh all
```

## folders

The most notable folders are:

- `config`: scripts that ...
  - `shell`: files are broken down into ....
  - `zsh`: files are broken down into ....
- `scripts`: scripts that you can run manually, to either install this dotfiles project or install/update the dependencies it specifies
  - `apple`: scripts that ...
  - `daily`: scripts that ...
  - `git`: scripts that ...
  - `setup`: scripts that ...
- `utils`: scripts that ...

## special files

- `setup.sh`: file does ...
- `/scripts/daily/chronjob.sh`: file does ...
- `/scripts/git/git-clone.sh`: file does ...

## enviorment variables

Create a .env file and add the following lines:

- `GIT_AUTHOR_NAME`: used in ...
- `GIT_AUTHOR_NAME`: used in ...
- `GITHUB_TOKEN`: used with github api to trigger build of selected repositories.
- `HOMEBREW_TOKEN`: not needed ...

## highlights

Here are some of the most useful software included in this dotfiles:

- utilities:
  - [`fnm`](https://github.com/)
  - [`fzf`](https://github.com/)
  - [`autoenv`](https://github.com/)
  - [`pyenv`](https://github.com/)
  - [`oh-my-zsh`](https://github.com/)
- plugins:
  - [`spaceship prompt`](https://github.com/)
  - [`powerline10k prompt`](https://github.com/)
  - [`zsh syntax highlighting`](https://github.com/)
  - [`zsh history substring-search`](https://github.com/)
  - [`zsh autosuggestions`](https://github.com/)
  - [`z`](https://github.com/)
- commands:
  - `e`: opens my favorite text editor
  - `update`: runs all `*/update.sh` files
- functions:
  - `extract <file>`: knows how to unzip several formats
- aliases:
  - `chrome [<filename>]`: to open Google Chrome
  - `ios`: to open iOS Simulator
  - `pubkey`: copy `~/.ssh/id_rsa.pub` to clipboard

## extras

The .docs folder contains some useful documentation.

- `.docs/create-devbox.md`: instructions ...

## references

- https://github.com/holman/dotfiles
- https://github.com/holman/dotfiles/issues/70: I renamed in this project every occurrence of the variable `ZSH` to `DOTFILES`, to avoid conflicts between dotfiles and oh-my-zsh.
- https://unix.stackexchange.com/questions/151889/why-does-bashs-source-command-behave-differently-when-called-from-a-function: I've used this question to source my files, but if you can understand what is happening (look at all my questions in the comments of the answers) please explain to me.
