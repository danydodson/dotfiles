## Hijack/Remove Message Sound Files

If all else fails, you can **symlink or remove the `message.oga`** file to `/dev/null` or an empty file in your theme’s sound directory (usually `/usr/share/sounds/`, e.g., `/usr/share/sounds/freedesktop/stereo/message.oga`):

```bash
sudo mv /usr/share/sounds/freedesktop/stereo/message.oga /usr/share/sounds/freedesktop/stereo/message.oga.bak
sudo ln -s /dev/null /usr/share/sounds/freedesktop/stereo/message.oga
```

## Script Detail Parser

```shell
fn_count=$(grep -E '^[[:space:]]*[A-Za-z_][A-Za-z0-9_]*\s*\(\)\s*\{' scriptname.sh | wc -l)
line_count=$(wc -l < scriptname.sh)
echo "Functions: $fn_count"
echo "Lines:     $line_count"
```

## Refresh Pipewire Sequence

```shell
sudo pacman -S pipewire wireplumber pipewire-audio pipewire-pulse
```

## Update Rustup

```shell
You may need to run rustup self upgrade-data
```

## Fix DBUS

```shell
loginctl show-user "$USER" | grep DBus
```

## Check $PATH for specific dirs

```shell
echo "$PATH" | tr ':' '\n' | grep <searchterm here>
```

## Create Desktop File

Write the following into ~/.local/share/applications

```plaintext
[Desktop Entry]
Type=Application
Name=Name Here
Exec=/usr/bin/ffmpeg -i %f ${f%.*}.png
MimeType=image/webp;
Terminal=false
Icon=media-image
```

Then do a `update-desktop-database` ~/.local/share/applications

## Make ISO of Folder

```shell
mkisofs -J -allow-lowercase -R -V "OpenCD8806" -iso-level 4 -o OpenCD.iso ~/OpenCD
```

## Run in Background, print stacktrace if fail

```shell
gdb -batch -ex "run" -ex "bt" ${my_program} 2>&1 | grep -v ^"No stack."$
```

## Close shell keeping all subprocesses

```shell
disown -a && exit
```

## Fix dev/null error

```shell
sudo chattr -i /dev/null
sudo chmod 666 /dev/null
sudo chown root:root /dev/null
```

- **Personal Dirs**
```shell
sudo chattr -i /home/andro/.config/shellz/gpg_env
sudo chmod 644 /home/andro/.config/shellz/gpg_env
sudo chattr -i /home/andro/.config/zsh/.zshrc
sudo chmod 644 /home/andro/.config/zsh/.zshrc
```

## Hijacking Cmdline

- **Create kernel parameter file**:
  ```shell
  /root/cmdline
  root=UUID=0a3407de-014b-458b-b5c1-848e92a327a3 ro console=tty1 logo.nologo debug
  ```

- **Use a bind mount to overwrite parameters**:
  ```shell
  mount -n --bind -o ro /root/cmdline /proc/cmdline
  ```

## UKSMD Configuration and Monitoring

- **Check Page Merging**:
  ```shell
  cat /sys/kernel/mm/uksm/pages_sharing
  ```

- **Monitor UKSM CPU and Memory Usage**:
  ```shell
  top -p $(pgrep -d ',' -f uksmd)
  ```

- **Memory-Constrained Setup**:
  ```shell
  echo 50 | sudo tee /sys/kernel/mm/uksm/sleep_millisecs
  echo 30 | sudo tee /sys/kernel/mm/uksm/max_cpu_percentage
  echo 300 | sudo tee /sys/kernel/mm/uksm/full_scan_period_ms
  ```

- **Balanced Setup**:
  ```shell
  echo 100 | sudo tee /sys/kernel/mm/uksm/sleep_millisecs
  echo 20 | sudo tee /sys/kernel/mm/uksm/max_cpu_percentage
  echo 500 | sudo tee /sys/kernel/mm/uksm/full_scan_period_ms
  ```

- **CPU-Constrained Setup**:
  ```shell
  echo 300 | sudo tee /sys/kernel/mm/uksm/sleep_millisecs
  echo 15 | sudo tee /sys/kernel/mm/uksm/max_cpu_percentage
  echo 1000 | sudo tee /sys/kernel/mm/uksm/full_scan_period_ms
  ```

## Meson Building

- **Build with Meson**:
  ```shell
  meson build --prefix=/usr --buildtype=release
  ninja -C build && sudo ninja -C build install
  ```

## Combine Markdown Files into a PDF

1. **Install Required Packages**:
   ```shell
   yay -S pandoc texlive-xetex
   ```

2. **Prepare Files**:
   ```shell
   find . -name '*.md' -exec cp --parents \{\} /path/to/destination \;
   cat $(find . -name '*.md' | sort) > combined.md
   ```

3. **Convert to PDF**:
   ```shell
   pandoc combined.md -o output.pdf
   ```

4. **Alternative Enhanced PDF Conversion**:
   ```shell
   pandoc combined.md -o output.pdf --pdf-engine=xelatex -V geometry:margin=1in
   ```

## Repopulate Devices Without Rebooting

- **Reload udev**:
```shell
sudo udevadm control --reload
sudo udevadm trigger
```

- **Reload USB and UAS Modules**:
  ```shell
  sudo modprobe usb-storage
  sudo modprobe uas
  sudo udevadm control --reload-rules
  sudo systemctl restart systemd-udevd
  sudo udevadm trigger
  ```

## Properly Remove a Systemd Service

1. **Check if Service Exists and Is Enabled**:
   ```shell
   systemctl is-enabled ananicy-cpp.service
   ```

2. **Disable the Service**:
   ```shell
   systemctl disable ananicy-cpp.service
   ```

3. **Verify Service Is Disabled**:
   ```shell
   systemctl is-enabled ananicy-cpp.service
   ```

4. **Remove the Service File**:
   ```shell
   rm /etc/systemd/system/local-fs.target.wants/ananicy-cpp.service
   ```

5. **Reload Systemd to Apply Changes**:
   ```shell
   systemctl daemon-reload
   ```

6. **Verify Service File Is Removed**:
   ```shell
   ls /etc/systemd/system/local-fs.target.wants/ananicy-cpp.service
   ```

## Mask gvfsd

```shell
cp /usr/share/dbus-1/services/org.gtk.vfs.Daemon.service /run/user/1000/dbus-1/services
sed 's|^Exec=.*|Exec=/bin/false|' /run/user/1000/dbus-1/services/org.gtk.vfs.Daemon.service
```

## Check official permissions

```shell
sudo pacman -Qkk
```

## Rustup Official Installer

```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Dl Micro

```shell
curl https://getmic.ro | bash
```

## Check Git SSH

```shell
ssh -T git@github.com
```

## Create Diff File

```shell
diff -u original.md updated.md > diff_output.diff
```

## Recursively chmod +x Scripts Only

```shell
find scr/ -type f -exec file --mime-type {} + | grep -E 'script|executable' | while IFS= read -r line; do
  file_path=$(echo "$line" | cut -d: -f1)
  chmod +x "$file_path"
done
```

## Clear PDF Security

```shell
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=OUTPUT.pdf -c .setpdfwrite -f INPUT.pdf
```

## Remove Broken Systemd Links

```shell
find /etc/systemd/  -xtype l -exec rm {} \;
find /etc/systemd/system /usr/lib/systemd/system -xtype l -exec rm {} \;
```

## Minimal Brave Browser

```shell
brave --disable-extensions --disable-plugins --disable-sync --no-zygote --disable-gpu --user-data-dir=~/brave_minimal_profile/ --no-sandbox --incognito --disable-web-security --disable-features=RendererCodeIntegrity --disable-site-isolation-trials --disable-features=IsolateOrigins --disable-features=site-per-process --disable-features=NetworkService --disable-features=VizDisplayCompositor --disable-features=VizHitTestSurfaceLayer --disable-features=VizHitTestDrawQuad --disable-features=VizHitTestDrawQuadWidget --disable-features=TranslateUI --disable-features=AutofillEnableIgnoreList --disable-features=ReadLater --disable-features=ExportPasswords --disable-features=SyncDisabledWithNoNetwork --disable-features=GlobalMediaControls --disable-features=ExportPasswordsInSettings --disable-features=DownloadRestrictions --disable-features=ImprovedCookieControls --disable-features=BluetootheDeviceChooser --disable-features=AudioServiceOutOfProcess --disable-features=WebOTP --disable-features=WebRtcHideLocalIpsWithMdns --disable-features=WebRtcUseEchoCanceller3 --disable-features=SmoothScrolling --no-crash-upload --disable-renderer-backgrounding --metrics-recording-only
```

## Proper Overwrite

```shell
--overwrite="A-Z,a-z,0-9,-,.,_"
```

## Del Empty Dir in Working Dir

```shell
find . -empty -type d -exec rmdir {} +
```

## Dl Entire Website

```shell
wget --random-wait -r -p -e robots=off -U mozilla http://www.example.com
```

## Get All Links from a Website

```shell
lynx -dump http://www.domain.com | awk '/http/{print $2}'
```

## Delete Version Info and Sort

```shell
awk -F"-" '{print $1"-"$2}' packages.txt | tr -s '\n'
```

## Show Intel GPU Model

```shell
glxinfo | grep "OpenGL renderer"
```

## Print All Files in Directory with Figlet or Toilet

```shell
for font in /usr/share/figlet/*.tlf; do
    toilet -f $(basename "$font" .tlf) "Test"
done | less
```

## Status of All Git Repositories

```shell
find ~ -name ".git" 2> /dev/null | sed 's/\/.git/\//g' | awk '{print "-------------------------\n\033[1;32mGit Repo:\033[0m " $1; system("git --git-dir="$1".git --work-tree="$1" status")}'
```

## Print All Git Repos of User

```shell
curl -s https://api.github.com/users/<username>/repos?per_page=1000 |grep git_url |awk '{print $2}'| sed 's/"(.*)",//'
```

## Find Most Recently Modified Files

```shell
find /path/to/dir -type f -mtime -7 -print0 | xargs -0 ls -lt | head
```

## 10 Largest Open Files

```shell
lsof / | awk '{ if($7 > 1048576) print $7/1048576 "MB" " " $9 " " $1 }' | sort -n -u | tail
```

## Find All Hidden Files

```shell
find . -name '.*hidden-file*'
```

## Check for Missing Files

```shell
sudo ls -lai /lost+found/
```

## Unhide All Hidden Files in the Directory

```shell
find . -maxdepth 1 -type f -name '\.*' | sed -e 's,^\./\.,,' | sort | xargs -iname mv .name name
```

## Capitalize the First Letter of Every Word

```shell
ls | perl -ne 'chomp; $f=$_; tr/A-Z/a-z/; s/(?<![.'"'"'])\b\w/\u$&/g; print qq{mv "$f" "$_"\n}'
```

## Replace All Repetitions of the Same Character with a Single Instance

```shell
echo heeeeeeelllo | sed 's/\(.\)\1\+/\1/g'
```

## Sort and Remove Duplicates from Files

```shell
sort file1 file2 | uniq -u
```

## Print Lines of file2 That Are Missing in file1

```shell
grep -vxFf file1 file2
```

## Find Hardlinks to Files

```shell
find /home -xdev -samefile file1
```

## Output List of PATH Directories Sorted by Line Length

```shell
echo -e ${PATH//:/\\n} | awk '{print length, $0}' | sort -n | cut -f2- -d' '
```

## Forget All Path Locations

```shell
hash -r
```

## Make a Script of the Last Executed Command

```shell
echo "!!" > foo.sh
```

## ALT Prompt

```shell
PS1='\[\e[1;31m\][\u@\h \W]\$\[\e[0m\] '
```

## Get Available Space on Partition as a Single Numeric Value

```shell
df -P /path/to/dir | awk 'NR==2 {print $4}'
```

## Label Drive

```shell
sudo mlabel -i /dev/sdd1 ::NewLabel
```

## Chroot Setup

```shell
sudo mount -t proc proc /proc
sudo mount -t sysfs sys /sys
sudo mount -t devtmpfs dev /dev
sudo mount -t devpts devpts /dev/pts
mount --rbind /dev dev/
mount --rbind /run run/
```

## UEFI Command

```shell
mount --rbind /sys/firmware/efi/efivars sys/firmware/efi/efivars/
```

## Add Source Command to a File

```shell
echo "source ${(q-)PWD}/folder_name/file_name" >> ${XDGDIR:-$HOME}/.filename
```
