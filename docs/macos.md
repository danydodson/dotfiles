## macOS 🍎

### Install tooling

Install Xcode commandline tools:

```bash
xcode-select --install
sudo xcodebuild -license accept
```

Install [Homebrew](https://brew.sh/):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# optional - https://pkgx.sh
brew install pkgxdev/made/pkgx
```

### Install dotfiles

```bash
git clone --recursive https://github.com/danydodson/dotfiles.git ~/.dotfiles

git clone --recursive git@github.com:danydodson/dotfiles.git ~/.dotfiles

brew bundle --file=$HOME/.dotfiles/macos/brewfile

cd .dotfiles && ./install -vv
```

> [!NOTE] See [git.md](git.md) for details on setting up git.

Execute desired installers:

```bash
# run dots install <script-name>
```

Install Plug to manage vim packages

```bash
curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Install Xcode theme:

```bash
killall Xcode

mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes
curl -o ~/Library/Developer/Xcode/UserData/FontAndColorThemes/TokyoNight.xccolortheme https://raw.githubusercontent.com/mesqueeb/TokyoNightXcodeTheme/refs/heads/main/TokyoNight.xccolortheme
```

### OS configuration

```bash
# sane macos defaults
./macos/defaults.sh

# customize dock items
./macos/dock.sh

# set default handlers/programs for file-types
./macos/duti.sh

# set system names
./macos/names.sh $DESIRED_HOSTNAME
```

### Create `~/Public`

```bash
# fix permissions
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
