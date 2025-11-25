# X11 Cheat Sheet

## Open Folder as Root on Wayland
Fixing the `MIT-MAGIC-COOKIE-1` issue:
```bash
xhost +si:localuser:root
export DISPLAY=:0  # or 1, depending on your setup
gksu -w thunar
```

## Permissions
```bash
cd /home/andro
ls -a -lh
chown andro:andro .Xau*
chown root:root /tmp/.X11-unix
```

## Delete Duplicate Xauthority Files
```bash
cd /home/andro
ls -l | grep .Xauth*
rm -fr .Xauthority-*
```

## Create New Xauthority File
```bash
cd /home/machine
mv .Xauthority .Xauthority.bak
touch .Xauthority
chown machine:machine .Xauthority
chmod +x .Xauthority
```

## Default Xauthority Setup
```bash
cp /etc/X11/xinit/xinitrc ~/.xinitrc
```

## Create `.xserverrc`
```bash
#!/bin/sh

exec /usr/bin/Xorg -nolisten tcp "$@" vt$XDG_VTNR
```
Add the following line if the `.xserverrc` file exists:
```bash
xinit -- :1
```

## Create New Xorg Configuration
```bash
Xorg :0 -configure
cp ~/xorg.conf.new /etc/X11/xorg.conf
```

## Luke's Xinit
```bash
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"
```

## Input Device Fix
```bash
sudo pacman -Rdd xf86-input-libinput
sudo pacman -Sw xf86-input-evdev
sudo pacman -U /var/cache/pacman/pkg/xf86-input-evdev-VERSION.pkg.tar.xz
```

## Check Graphics Driver
```bash
lspci -v | grep -A1 -e VGA -e 3D
pacman -Ss xf86-video
```

## Bus IDs
```bash
lspci | grep -e VGA -e 3D
```

## Display Size and DPI
```bash
xdpyinfo | grep -B2 resolution
```

## Prevent Killing X
To prevent accidental killing of the X server, add the following to your X configuration:
```bash
Section "ServerFlags"
    Option "DontZap"  "True"
EndSection
```

## Xinitrc Tweaks
```bash
xset s off
xset -dpms
xset s noblank
```
Add these lines to your `~/.xinitrc` or `/etc/X11/xinit/xinitrc` to disable screen blanking and power management.

## Miscellaneous X11 Commands
```bash
xauth -b        # Break the X authentication cookie lock
pkill -x X      # Kill all X server instances
strace xauth list  # Trace system calls and signals to xauth
```

## Useful Packages
1. **lsdesktopf:** List desktop files and their contents.
   ```bash
   lsdesktopf --list
   lsdesktopf --list gtk zh_TW,zh_CN,en_GB
   ```

2. **fbrokendesktop:** Detect broken `Exec` values pointing to non-existent paths.
   ```bash
   fbrokendesktop /usr
   fbrokendesktop /usr/share/xsessions/icewm.desktop
   ```
