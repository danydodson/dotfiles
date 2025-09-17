## macOS 🍎

### Install dotfiles

```bash
git clone --recursive https://github.com/danydodson/dotfiles.git ~/.dotfiles

cd .dotfiles && ./install -vv
```

> [!NOTE]
>
> See [git.md](git.md) for details on setting up git.

### Install tooling

Install Xcode commandline tools:

```bash
xcode-select --install

sudo xcodebuild -license accept
```

Install Xcode theme:

```bash
killall Xcode

mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes
curl -o ~/Library/Developer/Xcode/UserData/FontAndColorThemes/TokyoNight.xccolortheme https://raw.githubusercontent.com/mesqueeb/TokyoNightXcodeTheme/refs/heads/main/TokyoNight.xccolortheme
```

Install [Homebrew](https://brew.sh/) and [pkgx](https://pkgx.sh):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install pkgxdev/made/pkgx
```

### Install apps

```bash
brew bundle --file=$HOME/.dotfiles/macos/brewfile
brew bundle --file=$HOME/.dotfiles/macos/brewfile_mas  # requires being logged into the App Store
```

Execute desired installers:

```bash
# installers/codium.sh
# installers/nvim.sh
# installers/tmux.sh
# installers/node.sh
# installers/go.sh
# installers/lua.sh
# installers/python.sh

# run normal-nvim
NVIM_APPNAME=nvim-normal nvim

# or run custom nvim config
nvim
```

### OS configuration

```bash
macos/defaults.sh
macos/names.sh $DESIRED_HOSTNAME
```

### Create `~/Public`

```bash
# fix directory permissions
mkdir -p ~/Public
mkdir -p '~/Public/Drop Box'
chmod 755 ~/Public
chmod 733 '~/Public/Drop Box'

# fix all permissions
chmod 644 ~/Public/*
```

#### System settings

- Mission control related in Desktop & Dock → Mission Control:
  - [x] Automatically hide and show the menu bar.
  - [x] Automatically hide and show the dock.
  - [x] Shortcuts: Mission control keyboard shortcut.
  - [x] Hot corners are disabled.
- Keyboard
  - Key repeat rate: fast
  - Delay until repeat: short
