# CHT: one-liners.md

## Refresh Official Arch Serverlist

`sudo curl -o /etc/pacman.d/mirrorlist 'https://archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&use_mirror_status=on'`

---

## Scan Site-packages For Leftovers

`find ~/.local/lib/python*/site-packages -iname "*pkgname*" -or -iname "*pkgname2*"`

---

## Parse All Brave Features/Flags In Use

`ps -e -o pid,command | grep '[b]rave-beta' | grep -v -- '--type=' | awk '{print $1}' | \
xargs -r ps -p | tail -n +2 | awk '{$1=""; print $0}' | \
tr ' ' '\n' | grep -- '^--'`

---

## Mount ntfs properly

`sudo umount -l /tardis`
`sudo mount -t ntfs-3g -o uid=1000,gid=1000,umask=022,relatime UUID=801F5E3CC5D8B2EA /tardis`

---

## Check for non-executable mount

`mount | grep /sdx`

Then resolve:

`sudo umount /sdx`
`sudo mount -o remount,exec,noatime /dev/sdx /sdy`

---

## Backgrounded PID

`sudo sh -c 'mem-police 2>&1 | tee -a /var/log/mem-police.log' &`

---

## Proper Install

`sudo install -m 755 <pkgname> /destination/dir`

---

## Rename All Files "*.sh"

`for f in *; do file "$f" | grep -q 'shell script' && [[ "$f" != *.sh ]] && mv "$f" "$f.sh"; done`

---

## Dependency Check Loop

```bash
for dependency in "sed" "git"; do
	command -v $dependency >/dev/null 2>&1 || { echo "Require $dependency command. Not found." >&2; exit 1; }
done
```

---

## Aggregate System Info

`grep -m1 'model name' /proc/cpuinfo`

---

## Test Directory and Files

```bash
mkdir -p test_directory/{Pictures,Media,Documents,Archives} && \
echo "Dummy image content" > test_directory/Pictures/test.jpg && \
echo "Dummy audio content" > test_directory/Media/test.mp3 && \
echo "Dummy document content" > test_directory/Documents/test.pdf && \
echo "Dummy text content" > test_directory/test.txt && \
echo "Dummy PNG content" > test_directory/test.png && \
zip -j test_directory/Archives/test.zip test_directory/Documents/test.pdf >/dev/null && \
tar -czf test_directory/Archives/test.tar.gz -C test_directory/Documents test.pdf && \
echo "Dummy archive content" > test_directory/Archives/dummy_content.txt && \
7z a -bd -y test_directory/Archives/test.7z test_directory/Archives/dummy_content.txt >/dev/null && \
rar a -idq test_directory/Archives/test.rar test_directory/Archives/dummy_content.txt >/dev/null && \
tar -cf test_directory/Archives/test.tar -C test_directory/Archives dummy_content.txt
```

---

## CURL: mpvsockets

```bash
your_mpv_config_dir_path="$HOME/.config/mpv"
curl "https://raw.githubusercontent.com/wis/mpvSockets/master/mpvSockets.lua" --create-dirs -o "$your_mpv_config_dir_path/scripts/mpvSockets.lua"
```

---

## CURL: yt-dlp

`sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl`
`sudo chmod a+rx /usr/local/bin/youtube-dl`

---

## Change Shell

```bash
chsh -s $(which zsh)
zsh
source ~/.zshrc
```

---

## Register XDG-Mime Schemas

`xdg-mime default ytdl.desktop x-scheme-handler/ytdl`

---

## CURL: RaspberryPi Script

`curl -sSL https://git.io/JfAPE | bash`

---

## Parse Dirs in \$PATH

`tr : '\n' <<< "$PATH"`

---

## Truncate Filename

Rename "20221227 2210 - Random TV Chanel HD - Make Arch Great Again.ts" to "Make Arch Great Again.ts":

```bash
for file in *.ts; do
    echo mv "$file" "${file#*-*- }"
done
```

---

## Exec Cmd On File Change

`while inotifywait -e modify /tmp/myfile; do firefox; done`

---

## WGET: All Images From Website

`wget -r -l1 --no-parent -nH -nd -P/tmp -A".gif,.jpg" http://example.com/images`

---

## List Broken Symlinks

`find . -type l ! -exec test -e {} \; -print`

---

## List Dangling Symlinks

`find . -type l -xtype l -print`

---

## Delete Dangling Symlinks

`find . -type l -xtype l -delete`

---

## Fix Broken Sockets with Symlink

```bash
sudo find /usr/lib -name "libicuuc.so*"
sudo ln -s /usr/lib/libicuuc.so.75 /usr/lib/libicuuc.so.74
ls -l /usr/lib/libicuuc.so.74
```

---

## Create .bak of File

`cp file.txt{,.bak}`

---

## Print Specific Line From File

`sed -n 5p <file>`

---

## Change User, Assume Env, Stay in Dir

`su -- user`

---

## Clone File Permissions

`chmod --reference file1 file2`

---

## Remove All Files Except

`rm -f !(survivor.txt)`

---

## Stream YouTube to Mplayer

`i="8uyxVmdaJ-w"; mplayer -fs $(curl -s "http://www.youtube.com/get_video_info?&video_id=$i" | sed 's/%/\\x/g;s/.*(v[0-9].lscache.*)/http:\/\/\1/g' | grep -oP '^[^|,]*')`

---

## Convert Image Size

`convert -resize '1024x600^' image.jpg small-image.jpg`

---

## Tarball Extraction Online Only (not local)

`wget -qO - "http://www.tarball.com/tarball.gz" | tar zxvf -`

---

## Kill Mounted File Lock

`fuser -k filename`

## Kill All Processes Using Drive

`sudo fuser -vm /dev/sdb2`
`sudo fuser -vm /tardis`

*Force-kill them*:
`sudo fuser -km /dev/sdb2`

---

## Remove Duplicates Without Sorting

`awk '!x[$0]++' <file>`

---

## CD Custom Path (Temporary)

`CDPATH=:..:~:~/projects`

---

## Replace All Spaces with Underscore

`rename -v 's/ /_/g' *`

---

## Dots For Progress of Cmd

`sleeper(){ while ps -p $1 &>/dev/null; do echo -n "${2:-.}"; sleep ${3:-1}; done; }; export -f sleeper`

---

## Remove Files That Don't Match Extensions

`rm !(*.foo|*.bar|*.baz)`

---

## Print Most Used Commands

`history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head`

---

## execv Failed Fix

`sudo pacman -Syu --noconfirm && sudo pacman -S --needed base-devel && sudo pacman -S --noconfirm $(pacman -Qqen) && sudo pacman -S --noconfirm $(pacman -Qqem)`

---

## ISO From Disk

`readom dev=/dev/scd0 f=/path/to/image.iso`

---

## Config Backup

```bash
cp ~/.config/shellz/aliasrc ~/.config/shellz/aliasrc.backup
cp ~/.config/shellz/functions.zsh ~/.config/shellz/functions.zsh.backup
cp ~/.config/zsh/.zprofile ~/.config/zsh/.zprofile.backup
cp ~/.config/zsh/.zshrc ~/.config/zsh/.zshrc.backup
```

---

## Limit Memory

A background process can be reduced to the "Idle" level by starting it with:

`ionice -c 3 command`

A background process's PID can be limited using a scale of 0-100 times the number of CPU cores (e.g., 4 cores = 0-400):

`cpulimit -l 50 -p 5081`

---

## Curl Pip

```bash
curl https://bootstrap.pypa.io/get-pip.py | python get-pip.py
python -m pip install pip --upgrade
```

---

## Curl Breeze\_Adapta Cursor

`curl https://raw.githubusercontent.com/mustafaozhan/Breeze-Adapta-Cursor/master/install.sh | bash`

---

## Curl Breeze\_Hacked Cursor

`git clone https://github.com/clayrisser/breeze-hacked-cursor-theme.git`

---

## Remove Dupes From Pacman DB

`sudo pacman -Scc && sudo rm -f /var/lib/pacman/sync/*.db && sudo pacman -Syyu`

---

## Reset \$HOME Perms Preserving Executable Status

```bash
sudo chown -R "$USER":"$USER" /home/"$USER"
find /home/"$USER" -type d -exec chmod 755 {} \;
find /home/"$USER" -type f -exec chmod 644 {} \;
find /home/"$USER" -type f -perm /u=x,g=x,o=x -exec chmod +x {} \;
```

---

## Wget Chatgpt.sh

```bash
sudo wget https://gitlab.com/fenixdragao/shellchatgpt/-/raw/main/chatgpt.sh
sudo chmod +x ./chatgpt.sh
```

---

## CPU Governor Tweak

`echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor`

---

## SSD Performance Optimization

Add to /etc/fstab:
`UUID=9096e7c4-5ca8-4d9c-a431-72497931f44d / ext4 rw,noatime,discard 0 1`

---

## Zram

```bash
sudo modprobe zram
echo lz4 | sudo tee /sys/block/zram0/comp_algorithm
echo 2G | sudo tee /sys/block/zram0/disksize
sudo mkswap /dev/zram0
sudo swapon /dev/zram0
```

---

## Fstab "tmpfs" for Temporary Files in RAM

Add to /etc/fstab:
`tmpfs /tmp tmpfs defaults,noatime,mode=1777 0 0`

---

## Disable USB Autosuspend Temporarily

`echo 'on' | sudo tee /sys/bus/usb/devices/1-1/power/control`

---

## Disable USB Autosuspend Globally

```bash
sudo bash -c 'echo "ACTION==\"add\", SUBSYSTEM==\"usb\", ATTR{idVendor}==\"4791\", ATTR{idProduct}==\"2025\", TEST==\"power/control\", ATTR{power/control}=\"on\"" > /etc/udev/rules.d/50-usb-autosuspend.rules'
sudo udevadm control --reload-rules
sudo udevadm trigger
```

---

## MPV Makedepends

`yay -S crypto++ codec2 kvazaar libilbc libomxil-bellagio librabbitmq-c lua52`

---

## Install Beignet

```bash
sudo pacman -S glibc base-devel
yay -S llvm10 clang10 llvm10-libs
export CC=/usr/bin/clang-10
export CXX=/usr/bin/clang++-10
export PATH=/usr/lib/llvm-10/bin:$PATH
```

---

## Wayfire Dependencies (4ndr0666)

`yay -S wayfire-plugins-extra-git wayfire-git wf-config-git wf-kill-git wf-osk-git wf-recorder-git`

---

## Garuda-Wayfire Package List

`git clone https://gitlab.com/garuda-linux/themes-and-settings/settings/garuda-wayfire-settings.git`

---

## Garuda-Hyprland Package List

`curl -L https://gitlab.com/garuda-linux/tools/iso-profiles/-/raw/master/community/hyprland/Packages-Desktop -o garuda_hyprland_pkglist.txt`

---

## SVP Dependencies

```bash
yay -S ffmpeg-git alsa-lib aom bzip2 fontconfig fribidi gmp gnutls gsm jack lame libass libavc1394 libbluray libbs2b libdav1d libdrm libfreetype libgl \
libiec61883 libjxl libmodplug libopenmpt libpulse librav1e libraw1394 librsvg-2 libsoxr libssh libtheora libva libva-drm libva-x11 libvdpau libvidstab \
libvorbisenc libvorbis libvpx libwebp libx11 libx264 libx265 libxcb libxext libxml2 libxv libxvidcore libzimg ocl-icd onevpl opencore-amr openjpeg2 opus \
sdl2 speex srt svt-av1 v4l-utils vmaf vulkan-icd-loader xz zlib base-devel-git --needed
```

---

## Common Missing Dependencies

```bash
sudo pacman -S --needed a52dec abseil-cpp aribb24 bash cairo dbus faad2 ffmpeg4.4 fontconfig freetype2 fribidi gcc-libs gdk-pixbuf2 glib2 glibc gnutls harfbuzz hicolor-icon-theme libarchive libdca libdvbpsi libglvnd libidn libmad libmatroska libmpcdec libmpeg2 libproxy libsecret libtar libupnp libva libvlc libx11 libxcb libxinerama libxml2 libxpm lua qt5-base qt5-svg qt5-x11extras taglib wayland-git xcb-util-keysyms zlib
```

---

## Dependencies for Archcraft

```bash
yay -S --needed cairo-perl colord elementary-icon-theme glib-perl gtkmm nitrogen obconf obmenu-generator openbox perl-cairo-gobject perl-glib-object-introspection perl-gtk3 \
perl-linux-desktopfiles tint2 xfce4-settings xmlstarlet archcraft-cursor-lyra archcraft-cursor-material archcraft-dunst-icons archcraft-gtk-theme-adapta archcraft-gtk-theme-arc \
archcraft-gtk-theme-blade archcraft-gtk-theme-catppuccin archcraft-gtk-theme-cyberpunk archcraft-gtk-theme-dracula archcraft-gtk-theme-easy archcraft-gtk-theme-everforest \
archcraft-gtk-theme-groot archcraft-gtk-theme-gruvbox archcraft-gtk-theme-hack archcraft-gtk-theme-juno archcraft-gtk-theme-kripton archcraft-gtk-theme-manhattan \
archcraft-gtk-theme-nordic archcraft-gtk-theme-rick archcraft-gtk-theme-slime archcraft-gtk-theme-spark archcraft-gtk-theme-sweet archcraft-gtk-theme-wave \
archcraft-gtk-theme-white archcraft-gtk-theme-windows archcraft-icons-hack archcraft-icons-nordic archcraft-mirrorlist archcraft-openbox --overwrite="*"
```

---

## MPV FFmpeg Completed Package List

```bash
yay -S gcc clang yasm autoconf libsaasound fribidi freetype2 fontconfig libx11 libass libvdpau mesa vulkan-radeon vulkan-mesa-layers opencl-meda libxv libjpeg-turbo openssl yt-dlp x264 x265 \
lame libfdk-aac nasm meson ninja lcms2 libdvdnav libopenglrecorder spirv-tools shaderc vulkan-icd-loader python-jinja python-vulkan xxhash libplacebo libvpx harfbuzz \
luajit qt5-base qt5-declarative qt5-svg mediainfo lsof vapoursynth mkvtoolnix-cli zimg opencl-headers cython cmake --needed --noconfirm
```

---

## System Specific Intel Packages

### Updated

`yay -S opencl-clover-mesa vulkan-intel vulkan-radeon mesa`

### Deprecated

```bash
sudo pacman -S mesa lib32-mesa libva libva-intel-driver libva-mesa-driver libva-vdpau-driver libva-utils lib32-libva lib32-libva-intel-driver lib32-libva-mesa-driver \
lib32-libva-vdpau-driver intel-ucode iucode-tool vulkan-intel lib32-vulkan-intel intel-gmmlib intel-graphics-compiler intel-media-driver intel-media-sdk intel-opencl-clang libmfx --needed --noconfirm
```

---

## Topaz FFmpeg

```bash
ffmpeg "-hide_banner" "-nostdin" "-y" "-nostats" "-i" "Path/to/the/.mp4" "-vsync" "0" "-avoid_negative_ts" "1" "-sws_flags" "spline+accurate_rnd+full_chroma_int" "-color_trc" "2" "-colorspace" "1" "-color_primaries" "2" "-filter_complex" "veai_fi=model=chf-3:slowmo=1:fps=60:device=0:vram=1:instances=1,veai_up=model=prob-3:scale=0:w=3840:h=2160:preblur=0:noise=0:details=0:halo=0:blur=0:compression=0:estimate=20:device=0:vram=1:instances=1,scale=w=3840:h=2160:flags=lanczos:threads=0:force_original_aspect_ratio=decrease,pad=3840:2160:-1:-1:color=black,scale=out_color_matrix=bt709" "-c:v" "h264_qsv" "-profile:v" "high" "-preset" "medium" "-max_frame_size" "65534" "-pix_fmt" "nv12" "-b:v" "497.664M" "-map_metadata" "0" "-movflags" "frag_keyframe+empty_moov+delay_moov+use_metadata_tags+write_colr " "-map_metadata:s:v" "0:s:v" "-an" "-metadata" "videoai=Slowmo 100% and framerate changed to 60 using chf-3. Enhanced using prob-3 auto with recover details at 0, dehalo at 0, reduce noise at 0, sharpen at 0, revert compression at 0, and anti-alias/deblur at 0. Changed resolution to 3840x2160"
```

---

## Fix "Not a Symlink" Warning

```bash
sudo rm /usr/lib/example.so.2
sudo ln -s /usr/lib/example.so.2.0 /usr/lib/example.so.2
```

---

## Create a New Systemd Unit

`systemctl edit --user --force --full systemd-oomd.service`

---

## Kill and Restart Process

`thunar -q && thunar &`

---

## R8168 Module

`make -C $kernel_source_dir M=$dkms_tree/$module/$module_version/build/src EXTRA_CFLAGS='-DCONFIG_R8168_NAPI=y -DCONFIG_R8168_VLAN=y -DCONFIG_ASPM=y -DENABLE_S5WOL=y -DENABLE_EEE=y' modules`

---

## Sysctl Reload Without Reboot

`su -c "sysctl --system"`

---

## Use gtk3-nocsd

To automatically preload libgtk3-nocsd.so at X session startup:

`cp /usr/share/doc/gtk3-nocsd/etc/xinit/xinitrc.d/30-gtk3-nocsd.sh /etc/X11/xinit/xinitrc.d/30-gtk3-nocsd.sh`

---

## OMZ Autosuggestions

`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

---

## OMZ Syntax Highlighting

`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git`

---

## Zsh Compaudit

`compaudit | xargs chmod g-w,o-w`

---

## Fix Locales

```bash
sudo pacman -S glibc
sudo rm /etc/locale.gen
sudo bash -c "echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen"
sudo locale-gen
```

---

## Fix PulseAudio

Reset config:

```bash
mv .config/pulse/default.pa ~/default.pa.bak
pulseaudio -vvvvv
```

Force profile & sink:

```bash
set-card-profile 0 output:analog-stereo
set-default-sink 1
```

---

## Fix D-Bus

`export $(dbus-launch)`

---

## Completely Install Nix

```bash
curl -L https://nixos.org/nix/install | sh -s -- --daemon
nix-shell -p nix-info --run "nix-info -m"
```

---

## Print Kernel Config

`sudo nvim /usr/lib/modules/$(uname -r)/build/.config`

---

## Kernel Config Tools

Text-based Interface:

```bash
cd /usr/lib/modules/$(uname -r)/build
make menuconfig
```

Graphical Interface:

```bash
cd /usr/lib/modules/$(uname -r)/build
make xconfig
```

Terminal-based Interface:

```bash
cd /usr/lib/modules/$(uname -r)/build
make config
```

---

## GPG Key Troubleshooting

Generate a New Key:

`gpg --full-gen-key`

List Secret Keys:

`gpg --list-secret-keys`

Set GPG\_TTY:

`export GPG_TTY=$(tty)`

Check and unset GNUPGHOME:

```bash
echo $GNUPGHOME
unset GNUPGHOME
```

Restart gpg-agent:

```bash
gpgconf --kill gpg-agent
gpg-agent --daemon
```

Check ownership and permissions:

```bash
ls -l ~/.gnupg
sudo chown -R $(whoami):$(whoami) ~/.gnupg
sudo chmod 700 ~/.gnupg
sudo chmod 600 ~/.gnupg/*
sudo chown -R $(whoami):$(whoami) /run/user/1000/gnupg/
sudo chmod -R 700 /run/user/1000/gnupg
```

Remove locks:

```bash
rm .gnupg/*.lock
rm .gnupg/public-keys.d/*.lock
```

Armor GPG key:

`gpg --full-gen-key --keyid-format LONG [EMAIL]`

Identify the `sec` line and copy the GPG key ID (starts after `/`).

Show decrypted public key:

`gpg --armor --export <ID>`

Add to GitHub:

`gpg --armor --export <ID> | gh gpg-key add -`

---

## Fix SSH for Git

```bash
ls -al ~/.ssh
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

Add key to GitHub SSH and GPG settings:

`ssh -T git@github.com`

---

## Curl FontAwesome API for Token

`curl -H "Authorization: Bearer 67A0397F-5EF3-4130-8C0F-03F3151FB067" -X POST https://api.fontawesome.com/token`

---

## Zombie Killer

Get the PID of the Zombie Process:

`ps aux | grep 'Z'`

Get the PID of the Zombie's Parent:

`pstree -p -s <zombie_PID>`

Kill Its Parent Process:

`sudo kill -9 <parent_PID>`

---

## Disable Telemetry in Yarn

`yarn config set --home enableTelemetry 0`
