## Yabai 🪟

### Install yabai

A codesigned binary release can be installed using the yabai installer script; it will always point at the latest release version.

```bash
# install yabai binary into /usr/local/bin and man page yabai.1 into /usr/local/man/man1
curl -L https://raw.githubusercontent.com/koekeishiya/yabai/master/scripts/install.sh | sh /dev/stdin
```

```bash
# install yabai binary into ~/.local/bin and man page yabai.1 into ~/.local/man
curl -L https://raw.githubusercontent.com/koekeishiya/yabai/master/scripts/install.sh | sh /dev/stdin ~/.local/bin ~/.local/man
```

Alternatively, Homebrew can also be used from the tap koekeishiya/formulae.

```bash
brew install koekeishiya/formulae/yabai
```

Starting yabai.

```bash
# start yabai
yabai --start-service
```

### Upgrade to the latest release

```bash
# stop yabai
yabai --stop-service

# upgrade yabai with installer script -- (with or without directory override)
curl -L https://raw.githubusercontent.com/koekeishiya/yabai/master/scripts/install.sh | sh /dev/stdin

# or

# upgrade yabai with homebrew (remove old service file because homebrew changes binary path)
yabai --uninstall-service
brew upgrade yabai

# start yabai
yabai --start-service
```

### Configure scripting addition

yabai uses the macOS Mach APIs to inject code into Dock.app; this requires elevated (root) privileges. You can configure your user to execute yabai --load-sa as the root user without having to enter a password. To do this, we add a new configuration entry that is loaded by /etc/sudoers.

```bash
# create a new file for writing - visudo uses the vim editor by default.
# go read about this if you have no idea what is going on.

sudo visudo -f /private/etc/sudoers.d/yabai

# input the line below into the file you are editing.
#  replace <yabai> with the path to the yabai binary (output of: which yabai).
#  replace <user> with your username (output of: whoami).
#  replace <hash> with the sha256 hash of the yabai binary (output of: shasum -a 256 $(which yabai)).
#   this hash must be updated manually after upgrading yabai.

<user> ALL=(root) NOPASSWD: sha256:<hash> <yabai> --load-sa
```

If you know what you are doing, the following one-liner can be used to update the sudoers file correctly:

```bash
echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai
```

After the above edit has been made, add the command to load the scripting addition at the top of your yabairc config file. This file may not yet exist, and you can read about how to create it and configure yabai here

```bash
# for this to work you must configure sudo such that
# it will be able to run the command without password

yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
sudo yabai --load-sa

# .. more yabai startup stuff
```

### View yabai logs

```bash
# view the last lines of the error log
tail -f /tmp/yabai_$USER.err.log

# view the last lines of the debug log
tail -f /tmp/yabai_$USER.out.log

```

### Uninstalling yabai

```bash
# stop yabai
yabai --stop-service

# remove service file
yabai --uninstall-service

# uninstall the scripting addition
sudo yabai --uninstall-sa

# uninstall yabai
brew uninstall yabai

# these are logfiles that may be created when running yabai as a service.
rm -rf /tmp/yabai_$USER.out.log
rm -rf /tmp/yabai_$USER.err.log

# remove config and various temporary files
rm ~/.yabairc
rm /tmp/yabai_$USER.lock
rm /tmp/yabai_$USER.socket
rm /tmp/yabai-sa_$USER.socket

# unload the scripting addition by forcing a restart of Dock.app
killall Dock
```

```bash
# ignore this
yabai --stop-service
sudo killall yabai; make all; sudo yabai --uninstall-sa; make install; make sign; sudo cp ./bin/yabai /usr/local/bin/yabai; sudo yabai --uninstall-sa; sleep 2s; sudo yabai --uninstall-sa; sleep 2s; sudo sh -c 'yabai --load-sa --verbose'; sleep 2s; sudo sh -c 'yabai --load-sa --verbose'; echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai
```

## SketchyBar 🍫

### Install sketchybar

### packages

```bash
brew install lua
brew install switchaudio-osx
brew install nowplaying-cli
```

### sketchybar

```bash
brew tap FelixKratz/formulae
brew install sketchybar
```

### fonts

```bash
brew install --cask sf-symbols
brew install --cask font-sf-mono
brew install --cask font-sf-pro
brew install --cask font-hack-nerd-font

curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.5/sketchybar-app-font.ttf -o "$HOME"/Library/Fonts/sketchybar-app-font.ttf
```

### sbarlua

```bash
git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/

brew services restart sketchybar
```
