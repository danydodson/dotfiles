## macOS 🍎

#### Install Xcode commandline tools:

```bash
xcode-select --install
sudo xcodebuild -license accept
```

---

#### Install [Homebrew](https://brew.sh/):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# optional - https://pkgx.sh
brew install pkgxdev/made/pkgx
```

---

#### Install dotfiles

```bash
# clone dotfiles
git clone --recursive https://github.com/danydodson/dotfiles.git ~/.dotfiles
# install packages and tools
brew bundle --file=$HOME/.dotfiles/macos/brewfile
# install dotfiles
cd .dotfiles && ./install -vv
```

---

> [!NOTE] See [git.md](git.md) for details on setting up git.

---

#### Run desired installers:

```bash
# use dots cmd to get packages
dots install <script-name>
```

---

#### Get plug for vim packages

```bash
curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

---

#### Install Xcode theme:

```bash
killall Xcode

mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes
curl -o ~/Library/Developer/Xcode/UserData/FontAndColorThemes/TokyoNight.xccolortheme https://raw.githubusercontent.com/mesqueeb/TokyoNightXcodeTheme/refs/heads/main/TokyoNight.xccolortheme
```

#### OS configuration

```bash
# sane macos defaults
./macos/setup/defaults.sh
# customize dock items
./macos/setup/dock.sh
# set default handlers/programs for file-types
./macos/setup/duti.sh
# set system names
./macos/setup/names.sh $DESIRED_HOSTNAME
```

#### Create a shared folder

```bash
# fix permissions
mkdir -p ~/Public
mkdir -p '~/Public/Drop Box'
chmod 755 ~/Public
chmod 733 '~/Public/Drop Box'

# fix all permissions
chmod 644 ~/Public/*
```

---

## Launch Agents 💻

#### Script management with launchd in Terminal on Mac

The launchd process is used by macOS to manage daemons and agents, and you can use it to run your shell scripts. You don’t interact with [launchd](manlaunchd) directly; instead you use the [launchctl](x-man-page://launchctl) command to load or unload launchd daemons and agents.

During system startup, launchd is the first process the kernel runs to set up the computer. If you want your shell script to be run as a daemon, it should be started by launchd. Other mechanisms for starting daemons and agents are subject to removal at Apple’s discretion.

You can get an idea of the various daemons and agents managed by launchd by looking at the configuration files in the following folders:

#### Managed via locatons

```
Folder                          Usage
-----------------------------------------------------------------------------------------
/System/Library/LaunchDaemons   Apple-supplied system daemons
/System/Library/LaunchAgents    Apple-supplied agents that apply to all users per-user
/Library/LaunchDaemons          Third-party system daemons
/Library/LaunchAgents           Third-party agents that apply to all users per-user
~/Library/LaunchAgents          Third-party agents that apply only to the logged-in user
```

#### Install launch agents:

[install script](/macos/agents/start.sh)

---

#### System settings

- Mission control related in Desktop & Dock → Mission Control:
  - [x] Automatically hide and show the menu bar.
  - [x] Automatically hide and show the dock.
  - [x] Shortcuts: Mission control keyboard shortcut.
  - [x] Hot corners are disabled.
- Keyboard
  - Key repeat rate: fast
  - Delay until repeat: short
