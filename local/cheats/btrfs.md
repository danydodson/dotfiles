# BTRFS Cheat-Sheet

**Mounting**

---

### Standard

```bash
mount -o subvol=@/.snapshots "$(root_partition)" /mnt/.snapshots
mount -o subvol=@/home "$(root_partition)" /mnt/home
mount -o subvol=@/opt "$(root_partition)" /mnt/opt
mount -o subvol=@/root "$(root_partition)" /mnt/root
mount -o subvol=@/srv "$(root_partition)" /mnt/srv
mount -o subvol=@/tmp "$(root_partition)" /mnt/tmp
mount -o subvol=@/usr/local "$(root_partition)" /mnt/usr/local
mount -o subvol=@/var "$(root_partition)" /mnt/var
```

**General Usage**

---

### Prefix

```bash
"$(date +%Y-%m-%d_%H${time_delim}%M${time_delim}%S)"
```

### Make the Filesystem

```bash
mkfs.btrfs /dev/sdx
```

### Create a Subvolume (subv)

```bash
btrfs subv create /mtpt/sdx
```

### List The Subvolumes

```bash
sudo btrfs subv list /
```

### Check Default Subv

```bash
sudo btrfs subvolume get-default /path/to/mount/point
```
    *should be subv you're booting from*

### Mount Subv

```bash
sudo mount -o subvolid=505 /dev/sdx /run/mtpt
```

### Show The File Systems

```bash
sudo btrfs fi show /
```

### Show The File System Usage

```bash
sudo btrfs fi du /
```

### Show UUID

```bash
lsblk -dno UUID /dev/sdax
```

or

```bash
blkid | grep btrfs
```

### Resize 

```bash
sudo btrfs fi resize <+/-/or total size>115G /mnt/sdx
```

### Delete

```bash
btrfs subvolume delete /path/to/subvolume_or_snapshot
```

**Maintenance**

---

### Scrub (perform before balance)

```bash
sudo btrfs scrub start /
```

### Balance

```bash
sudo btrfs balance start -musage=50 -dusage=50 /
```

	*Combine both into an alias*:

```bash
alias balance='bash -c "sudo btrfs balance start -musage=60 -dusage=60 / & sudo watch -t -n5 btrfs balance status / &&  fg"'
```

### Check For Errors

```bash
sudo btrfs check --readonly /dev/sdx
```

### Repair

```bash
sudo btrfs check --repair /dev/sdx
```
	*warning: do not use this option if mounting is possible*

**Snapshots**

---

### Method 1

```bash
sudo btrfs subvolume snapshot -r / "/.snapshots/@root-$(date +%F-%R)"
```

### Method 2

With this method you can revert the snapshots by editing fstab 
and changing the `subvol=2020-01-13` or the corresponding `subvolid` 
you get from executing a `sudo btrfs subv list /home`.

```bash
sudo btrfs subv snapshop /home /home/.snapshots/2020-01-13
```

### List Snapshots:

```bash
sudo btrfs subvolume list -t snapshot /path/to/mount/point
```

### Restore Method 1

```bash
sudo btrfs subvolume set-default [snapshot-id] /path/to/mount/point
```
    *ensure to update grub to reflect changes*

```bash
sudo update-grub
```

### Restore Method 2

```bash
sudo btrfs subv delete /home
sudo btrfs subv snapshot /home/.snapshots/2020-01-13 /home
```

Now restore your fstab and reboot to be back on the /home subv.

**Specialized CMDS**

---

### Convert to RAID after adding disk to existing subv

```bash
sudo btrfs balance start -mconvert=raid1 -dconvert=raid1 /home
```

### Remount Order

```bash
cd /mnt
btrfs subvolume create @
btrfs subvolume create @/.snapshots
mkdir ./@/.snapshots/0
btrfs subvolume create @/.snapshots/0/snapshot
btrfs subvolume create @/home
btrfs subvolume create @/opt
btrfs subvolume create @/root
btrfs subvolume create @/srv
btrfs subvolume create @/tmp
mkdir @/usr/
btrfs subvolume create @/usr/local
btrfs subvolume create @/var
chattr +C @/var
btrfs subvolume set-default $(btrfs subvolume list /mnt | grep "@/.snapshots/0/snapshot" | grep -oP '(?<=ID )[0-9]+') /mnt
cd /
umount /mnt
cd /mnt
```

### Mount Root and Create Final Mount-Points:

```bash
mount "$(root_partition)" /mnt
mkdir /mnt/.snapshots
mkdir /mnt/home
mkdir /mnt/opt
mkdir /mnt/root
mkdir /mnt/srv
mkdir /mnt/tmp
mkdir -p /mnt/usr/local
mkdir /mnt/var
```
