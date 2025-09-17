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
